from contextlib import closing
from datetime import datetime, timezone
import sqlite3
from stat import S_ISREG

from django.conf import settings
from django.utils.dateparse import parse_datetime


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


def ultima_medicao():
    uri = settings.MYCOLAB_LIVE_READINGS.resolve().as_uri() + "?mode=ro"
    try:
        with closing(sqlite3.connect(uri, uri=True, timeout=1)) as db:
            leitura = db.execute(
                """
                SELECT measured_at, temperature_c, humidity_percent
                  FROM projects_growboxreading
                 ORDER BY measured_at DESC, id DESC
                 LIMIT 1
                """
            ).fetchone()
    except sqlite3.Error:
        return None
    if leitura is None:
        return None

    data, temperatura, humidade = leitura
    try:
        medida_em = parse_datetime(data)
    except (TypeError, ValueError):
        return None
    if medida_em is None:
        return None
    if medida_em.tzinfo is None:
        medida_em = medida_em.replace(tzinfo=timezone.utc)
    return {"medida_em": medida_em, "temperatura": temperatura, "humidade": humidade}
