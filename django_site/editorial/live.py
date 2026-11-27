import json
import sqlite3
from contextlib import closing
from datetime import datetime, timedelta, timezone
from pathlib import Path
from stat import S_ISREG
from tempfile import NamedTemporaryFile

from django.conf import settings
from django.utils.dateparse import parse_datetime

CAMPOS_EXTERIORES = ("external_temperature_c", "external_humidity_percent")
CAMPOS_RELES = ("fan_on", "humidifier_on")
INTERVALO_MAX_RELE = timedelta(minutes=2)


def ultima_fotografia():
    try:
        meta = settings.MYCOLAB_LIVE_PHOTO.stat()
    except OSError:
        return None
    if not S_ISREG(meta.st_mode):
        return None
    return {
        "capturada_em": datetime.fromtimestamp(meta.st_mtime, tz=timezone.utc),
        "versao": str(meta.st_mtime_ns),
    }


def _ficheiro_capturas():
    return settings.MYCOLAB_LIVE_PHOTO.with_name("myco-site-capturas.json")


def _capturas_guardadas():
    try:
        captura = json.loads(_ficheiro_capturas().read_text())
        return sorted({int(versao) for versao in captura})[-2:]
    except (OSError, ValueError, TypeError):
        return []


def registar_fotografia():
    foto = ultima_fotografia()
    if foto is None:
        return
    ficheiro = _ficheiro_capturas()
    capturas = _capturas_guardadas()
    novas = sorted({*capturas, int(foto["versao"])})[-2:]
    if novas == capturas:
        return
    with NamedTemporaryFile(mode="w", dir=ficheiro.parent, delete=False) as temporario:
        nome = Path(temporario.name)
        json.dump(novas, temporario)
    try:
        nome.replace(ficheiro)
    finally:
        nome.unlink(missing_ok=True)


def _penultima_fotografia(foto):
    if foto is None:
        return None
    anteriores = [versao for versao in _capturas_guardadas() if versao < int(foto["versao"])]
    if anteriores:
        return datetime.fromtimestamp(anteriores[-1] / 1_000_000_000, tz=timezone.utc)
    return None


def _data_leitura(valor):
    try:
        data = parse_datetime(valor)
    except (TypeError, ValueError):
        return None
    if data and data.tzinfo is None:
        return data.replace(tzinfo=timezone.utc)
    return data


def _data_sql(data):
    return data.astimezone(timezone.utc).replace(tzinfo=None).isoformat(sep=" ")


def _historico(db, colunas, inicio):
    temperaturas = ("temperature_c", "humidity_percent", *CAMPOS_EXTERIORES)
    medias = ", ".join(
        f"ROUND(AVG({campo}), 1)" if campo in colunas else "NULL"
        for campo in temperaturas
    )
    return db.execute(
        f"""
        SELECT CAST(strftime('%s', measured_at) AS INTEGER) / 300 * 300, {medias}
          FROM projects_growboxreading
         WHERE measured_at >= ?
         GROUP BY 1
         ORDER BY 1
        """,
        (_data_sql(inicio),),
    ).fetchall()


def _duracao(segundos):
    horas, restante = divmod(int(segundos), 3600)
    minutos, segundos = divmod(restante, 60)
    return f"{horas:02d}:{minutos:02d}:{segundos:02d}"


def _funcionamento(db, colunas, inicio, fim):
    if not inicio or not fim or inicio >= fim:
        return None
    estados = ", ".join(campo if campo in colunas else "NULL" for campo in CAMPOS_RELES)
    parametros = (_data_sql(inicio), _data_sql(fim))
    leituras = db.execute(
        f"""
        SELECT measured_at, {estados}
          FROM projects_growboxreading
         WHERE measured_at >= COALESCE(
             (SELECT MAX(measured_at) FROM projects_growboxreading WHERE measured_at <= ?),
             ?
         )
           AND measured_at <= COALESCE(
             (SELECT MIN(measured_at) FROM projects_growboxreading WHERE measured_at >= ?),
             ?
         )
         ORDER BY measured_at, id
        """,
        (parametros[0], parametros[0], parametros[1], parametros[1]),
    )
    ligado = [0.0, 0.0]
    observado = [0.0, 0.0]
    anterior = None
    for data, *valores in leituras:
        instante = _data_leitura(data)
        if instante is None:
            continue
        if anterior:
            antes, estados_anteriores = anterior
            if instante - antes <= INTERVALO_MAX_RELE:
                segundos = (min(instante, fim) - max(antes, inicio)).total_seconds()
                if segundos > 0:
                    for i, estado in enumerate(estados_anteriores):
                        if estado in (0, 1):
                            observado[i] += segundos
                            ligado[i] += segundos * estado
        anterior = instante, valores

    total = (fim - inicio).total_seconds()
    return [
        {"duracao": _duracao(ligado[i]), "parcial": observado[i] < total - 0.01}
        if observado[i] else None
        for i in range(len(CAMPOS_RELES))
    ]


def estado_live():
    foto = ultima_fotografia()
    anterior = _penultima_fotografia(foto)
    fim = foto["capturada_em"] if foto else None
    proxima = fim + timedelta(seconds=settings.MYCOLAB_PHOTO_INTERVAL_SECONDS) if fim else None
    painel = {
        "foto": foto,
        "foto_anterior": anterior,
        "proxima_fotografia": proxima,
        "leitura": None,
        "historico": [],
        "reles": None,
    }
    uri = settings.MYCOLAB_LIVE_READINGS.resolve().as_uri() + "?mode=ro"
    try:
        with closing(sqlite3.connect(uri, uri=True, timeout=1)) as db:
            colunas = {linha[1] for linha in db.execute("PRAGMA table_info(projects_growboxreading)")}
            exteriores = ", ".join(campo if campo in colunas else "NULL" for campo in CAMPOS_EXTERIORES)
            leitura = db.execute(
                f"""
                SELECT measured_at, temperature_c, humidity_percent, {exteriores}
                  FROM projects_growboxreading
                 ORDER BY measured_at DESC, id DESC
                 LIMIT 1
                """
            ).fetchone()
            if leitura:
                data, temperatura, humidade, temperatura_exterior, humidade_exterior = leitura
                painel["leitura"] = {
                    "medida_em": _data_leitura(data),
                    "temperatura": temperatura,
                    "humidade": humidade,
                    "temperatura_exterior": temperatura_exterior,
                    "humidade_exterior": humidade_exterior,
                }
            inicio_historico = datetime.now(timezone.utc) - timedelta(hours=24)
            painel["historico"] = _historico(db, colunas, inicio_historico)
            painel["reles"] = _funcionamento(db, colunas, anterior, fim)
    except sqlite3.Error:
        pass
    return painel
