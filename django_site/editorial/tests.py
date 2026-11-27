from datetime import datetime, timedelta, timezone
import os
from pathlib import Path
import sqlite3
from tempfile import TemporaryDirectory

from django.contrib.auth import get_user_model
from django.test import TestCase
from PIL import Image

from .live import registar_fotografia
from .models import Artigo, Cogumelo, GuiaGrowBox, MetodoCultivo, Pagina, Timelapse


class IdiomasTest(TestCase):
    def test_paginas_e_navegacao_em_tres_idiomas(self):
        traducoes = (
            ("", "pt-pt", "Cogumelos", "Como tudo começou"),
            ("/de", "de", "Pilze", "Wie alles begann"),
            ("/en", "en", "Mushrooms", "How it all began"),
        )
        for prefixo, idioma, titulo, titulo_sobre in traducoes:
            with self.subTest(idioma=idioma):
                inicio = self.client.get(prefixo + "/")
                self.assertContains(inicio, f'href="{prefixo}/cogumelos/"')
                self.assertContains(
                    inicio,
                    f'<a class="botao" href="{prefixo}/sobre/">{titulo_sobre}</a>',
                )
                pagina = self.client.get(prefixo + "/cogumelos/")
                self.assertEqual(pagina.headers["Content-Language"], idioma)
                self.assertContains(pagina, f"<h1>{titulo}</h1>")
                for destino, codigo, _, _ in traducoes:
                    self.assertContains(pagina, f'href="{destino}/cogumelos/" hreflang="{codigo}"')

    def test_seletor_conserva_ficha_e_pagina_do_catalogo(self):
        Cogumelo.objects.bulk_create([
            Cogumelo(titulo=f"Cogumelo {n}", slug=f"cogumelo-{n}", publicado=True)
            for n in range(19)
        ])
        pagina = self.client.get("/en/cogumelos/?page=2")
        self.assertContains(pagina, 'href="/de/cogumelos/?page=2" hreflang="de"')
        self.assertContains(pagina, "Page 2 of 2")
        ficha = self.client.get("/de/cogumelos/cogumelo-0/")
        self.assertContains(ficha, 'href="/en/cogumelos/cogumelo-0/" hreflang="en"')
        self.assertContains(ficha, "<h1>Cogumelo 0</h1>")

    def test_usa_traducao_e_recua_para_portugues_quando_falta(self):
        Artigo.objects.create(
            titulo="O primeiro artigo",
            titulo_de="Der erste Artikel",
            slug="primeiro-artigo",
            publicado=True,
            resumo="Resumo português.",
            texto="Texto português.",
            texto_de="Deutscher Text.",
            texto_en="English text.",
        )
        Pagina.objects.create(secao=Pagina.Secao.SOBRE, texto_en="The story in English.")
        alemao = self.client.get("/de/a-volta-dos-cogumelos/primeiro-artigo/")
        self.assertContains(alemao, "<h1>Der erste Artikel</h1>")
        self.assertContains(alemao, "Resumo português.")
        self.assertContains(alemao, "Deutscher Text.")
        self.assertNotContains(alemao, "Texto português.")
        ingles = self.client.get("/en/a-volta-dos-cogumelos/primeiro-artigo/")
        self.assertContains(ingles, "<h1>O primeiro artigo</h1>")
        self.assertContains(ingles, "English text.")
        self.assertContains(self.client.get("/en/sobre/"), "The story in English.")

    def test_painel_expoe_campos_de_traducao(self):
        utilizador = get_user_model().objects.create_superuser("editor")
        self.client.force_login(utilizador)
        for modelo, campo in (
            ("pagina", "introducao"),
            ("artigo", "texto"),
            ("cogumelo", "titulo"),
            ("metodocultivo", "resumo"),
        ):
            with self.subTest(modelo=modelo):
                pagina = self.client.get(f"/admin/editorial/{modelo}/add/")
                self.assertContains(pagina, f'name="{campo}_de"')
                self.assertContains(pagina, f'name="{campo}_en"')

    def test_sobre_mostra_o_texto_na_coluna_do_titulo_ao_lado_da_imagem(self):
        Pagina.objects.create(
            secao=Pagina.Secao.SOBRE,
            texto="A minha história.",
            texto_de="Meine Geschichte.",
            texto_en="My story.",
            imagem="paginas/sobre.webp",
        )
        for prefixo, texto in (
            ("", "A minha história."),
            ("/de", "Meine Geschichte."),
            ("/en", "My story."),
        ):
            with self.subTest(prefixo=prefixo):
                resposta = self.client.get(f"{prefixo}/sobre/")
                self.assertContains(resposta, texto, count=1)
                abertura = resposta.content.decode().split('<section class="abertura abertura-sobre">', 1)[1]
                coluna, imagem = abertura.split('<img class="abertura-imagem"', 1)
                self.assertIn(f'<div class="leitura"><p>{texto}</p></div>', coluna)
                self.assertIn('src="/media/paginas/sobre.webp"', imagem)


class PaginaInicialTest(TestCase):
    def test_ficha_mycobox_no_inicio_abre_a_pagina_das_experiencias(self):
        for prefixo in ("", "/de", "/en"):
            with self.subTest(prefixo=prefixo):
                inicio = self.client.get(f"{prefixo}/")
                self.assertContains(inicio, 'class="cartao"', count=4)
                self.assertContains(inicio, f'class="cartao" href="{prefixo}/mycobox/"')
                self.assertContains(inicio, '<span class="cartao-titulo">MycoBox</span>')
                self.assertContains(inicio, "/static/editorial/growbox.webp")
                self.assertNotContains(inicio, f'class="cartao" href="{prefixo}/growbox/"')

                mycobox = self.client.get(f"{prefixo}/mycobox/")
                for caminho in ("mycobox/timelapses/", "mycobox/live/", "growbox/"):
                    self.assertContains(mycobox, f'href="{prefixo}/{caminho}"')

    def test_growbox_apresenta_o_projeto_enquanto_nao_ha_guias(self):
        GuiaGrowBox.objects.create(titulo="Guia em rascunho", slug="rascunho")
        for prefixo, introducao, aviso in (
            ("", "Aprende a montar a tua GrowBox", "Os primeiros guias estão em preparação."),
            ("/de", "Hier lernst du, wie du deine GrowBox", "Die ersten Anleitungen sind in Vorbereitung."),
            ("/en", "Learn how to build your GrowBox", "The first guides are in preparation."),
        ):
            with self.subTest(prefixo=prefixo):
                catalogo = self.client.get(f"{prefixo}/growbox/")
                self.assertContains(catalogo, "<h1>GrowBox</h1>")
                abertura, corpo = catalogo.content.decode().split("</section>", 1)
                self.assertIn(introducao, abertura)
                self.assertIn('src="/static/editorial/abertura-growbox.webp"', abertura)
                self.assertIn(aviso, corpo)
                self.assertContains(catalogo, f'href="{prefixo}/mycobox/"')
                self.assertNotContains(catalogo, "Guia em rascunho")

    def test_catalogo_growbox_leva_ao_guia_traduzido(self):
        guia = GuiaGrowBox.objects.create(
            titulo="Câmara e timelapse",
            titulo_en="Camera and time-lapse",
            slug="camara-e-timelapse",
            publicado=True,
            preco="9 CHF",
            url_compra="https://example.org/guia",
        )
        catalogo = self.client.get("/en/growbox/")
        self.assertContains(catalogo, "<h1>GrowBox</h1>")
        self.assertContains(catalogo, "Learn how to build your GrowBox")
        self.assertNotContains(catalogo, "The first guides are in preparation.")
        _, fichas = catalogo.content.decode().split("</section>", 1)
        self.assertIn('<ul class="grelha">', fichas)
        self.assertIn("Camera and time-lapse", fichas)
        self.assertIn('href="/en/growbox/camara-e-timelapse/"', fichas)
        ficha = self.client.get("/en/growbox/camara-e-timelapse/")
        self.assertContains(ficha, "Buy the PDF guide")
        guia.publicado = False
        guia.save()
        self.assertEqual(self.client.get("/en/growbox/camara-e-timelapse/").status_code, 404)

    def test_novidades_mostram_apenas_as_tres_publicacoes_datadas_mais_recentes(self):
        data = datetime(2026, 11, 27, 9, tzinfo=timezone.utc)
        Artigo.objects.create(
            titulo="Artigo mais antigo", slug="antigo", publicado=True, publicado_em=data,
        )
        Artigo.objects.create(titulo="Rascunho", slug="rascunho", publicado_em=data + timedelta(days=5))
        Cogumelo.objects.create(
            titulo="Cogumelo novo", slug="novo", publicado=True, publicado_em=data + timedelta(days=1),
        )
        MetodoCultivo.objects.create(
            titulo="Método novo", slug="novo", publicado=True, publicado_em=data + timedelta(days=2),
        )
        GuiaGrowBox.objects.create(
            titulo="Guia novo", titulo_de="Neue Anleitung", slug="novo", publicado=True,
            publicado_em=data + timedelta(days=3),
        )
        resposta = self.client.get("/de/")
        html = resposta.content.decode()
        self.assertContains(resposta, "Was gibt es Neues?")
        self.assertContains(resposta, 'href="/de/growbox/novo/"')
        self.assertContains(resposta, '<time datetime="2026-11-30T10:00:00+01:00">')
        self.assertLess(html.index("Neue Anleitung"), html.index("Método novo"))
        self.assertLess(html.index("Método novo"), html.index("Cogumelo novo"))
        self.assertNotContains(resposta, "Artigo mais antigo")
        self.assertNotContains(resposta, "Rascunho")

    def test_data_e_definida_na_primeira_publicacao_e_mantida_nas_edicoes(self):
        artigo = Artigo.objects.create(titulo="Artigo", slug="artigo")
        self.assertIsNone(artigo.publicado_em)
        artigo.publicado = True
        artigo.save(update_fields=["publicado"])
        artigo.refresh_from_db()
        primeira_publicacao = artigo.publicado_em
        self.assertIsNotNone(primeira_publicacao)
        artigo.publicado = False
        artigo.save()
        self.assertNotContains(self.client.get("/"), 'href="/a-volta-dos-cogumelos/artigo/"')
        artigo.publicado = True
        artigo.save()
        artigo.refresh_from_db()
        self.assertEqual(artigo.publicado_em, primeira_publicacao)


class CatalogoAberturaTest(TestCase):
    def test_abertura_traduzida_fica_acima_das_fichas(self):
        Artigo.objects.create(titulo="Artigo publicado", slug="publicado", publicado=True)
        for prefixo, frase in (
            ("", "Descobre o que é um cogumelo"),
            ("/de", "Entdecke, was ein Pilz ist"),
            ("/en", "Discover what a mushroom is"),
        ):
            with self.subTest(prefixo=prefixo):
                pagina = self.client.get(f"{prefixo}/a-volta-dos-cogumelos/")
                self.assertContains(pagina, f'href="{prefixo}/a-volta-dos-cogumelos/publicado/"')
                abertura, fichas = pagina.content.decode().split("</section>", 1)
                self.assertIn(frase, abertura)
                self.assertIn('class="abertura-texto"', abertura)
                self.assertIn('src="/static/editorial/abertura-artigos.webp"', abertura)
                self.assertIn('<ul class="grelha">', fichas)

    def test_catalogo_cogumelos_mostra_mesa_de_estudo_acima_das_fichas(self):
        Cogumelo.objects.create(
            titulo="Cogumelo-ostra",
            slug="cogumelo-ostra",
            esboco="esbocos/cogumelo-ostra.webp",
            publicado=True,
        )
        for prefixo, frase in (
            ("", "Explora as fichas para conhecer diferentes cogumelos"),
            ("/de", "Entdecke in den Steckbriefen verschiedene Pilze"),
            ("/en", "Explore the profiles to learn about different mushrooms"),
        ):
            with self.subTest(prefixo=prefixo):
                pagina = self.client.get(f"{prefixo}/cogumelos/")
                self.assertContains(pagina, f'href="{prefixo}/cogumelos/cogumelo-ostra/"')
                abertura, fichas = pagina.content.decode().split("</section>", 1)
                self.assertIn(frase, abertura)
                self.assertIn('src="/static/editorial/abertura-cogumelos.webp"', abertura)
                self.assertIn('<ul class="grelha">', fichas)
                self.assertIn('src="/media/esbocos/cogumelo-ostra.webp"', fichas)

    def test_catalogo_cultivo_mostra_introducao_traduzida_e_imagem_acima_dos_metodos(self):
        MetodoCultivo.objects.create(titulo="Cultivo em saco", slug="em-saco", publicado=True)
        for prefixo, frase in (
            ("", "Descobre diferentes formas de cultivar cogumelos."),
            ("/de", "Entdecke verschiedene Möglichkeiten, Pilze anzubauen."),
            ("/en", "Discover different ways to grow mushrooms."),
        ):
            with self.subTest(prefixo=prefixo):
                pagina = self.client.get(f"{prefixo}/cultivo/")
                self.assertContains(pagina, f'href="{prefixo}/cultivo/em-saco/"')
                abertura, fichas = pagina.content.decode().split("</section>", 1)
                self.assertIn(frase, abertura)
                self.assertIn('src="/static/editorial/abertura-cultivo.webp"', abertura)
                self.assertIn('<ul class="grelha">', fichas)

    def test_abertura_usa_introducao_e_imagem_guardadas(self):
        Pagina.objects.create(
            secao=Pagina.Secao.ARTIGOS,
            introducao="Introdução do editor.",
            introducao_en="The editor's introduction.",
            imagem="paginas/artigos.webp",
            imagem_alt_en="Woodland mushrooms",
        )
        pagina = self.client.get("/en/a-volta-dos-cogumelos/")
        self.assertContains(pagina, "The editor&#x27;s introduction.")
        self.assertContains(pagina, 'src="/media/paginas/artigos.webp" alt="Woodland mushrooms"')
        self.assertNotContains(pagina, "Discover what a mushroom is")


class MycoBoxTest(TestCase):
    def test_fichas_e_galeria_aproveitam_o_timelapse_anterior(self):
        Pagina.objects.create(secao=Pagina.Secao.MYCOBOX, timelapse="videos/colheita.mp4")
        Timelapse.objects.create(titulo="Nova experiência", titulo_en="New experiment", video="videos/novo.mp4")
        pagina = self.client.get("/mycobox/")
        self.assertContains(pagina, 'href="/mycobox/timelapses/"')
        self.assertContains(pagina, 'href="/mycobox/live/"')
        self.assertContains(pagina, 'src="/media/videos/colheita.mp4"')
        galeria = self.client.get("/en/mycobox/timelapses/")
        self.assertContains(galeria, "<h1>Time-lapses</h1>")
        self.assertContains(galeria, "New experiment")
        self.assertContains(galeria, 'src="/media/videos/novo.mp4"')
        self.assertContains(galeria, 'src="/media/videos/colheita.mp4"')

    def test_live_indica_quando_os_dados_ainda_nao_chegaram(self):
        with TemporaryDirectory() as pasta:
            foto = Path(pasta) / "latest.jpg"
            base = Path(pasta) / "montra.sqlite3"
            with self.settings(MYCOLAB_LIVE_PHOTO=foto, MYCOLAB_LIVE_READINGS=base):
                pagina = self.client.get("/mycobox/live/")
                self.assertContains(pagina, "Ainda não há uma fotografia disponível.")
                self.assertContains(pagina, "Há leituras por receber.")
                self.assertContains(pagina, "À espera da próxima fotografia.")
                estado = self.client.get("/mycobox/live/foto/estado/")
                self.assertEqual(estado.json(), {"versao": None})
                self.assertEqual(self.client.get("/mycobox/live/foto/").status_code, 404)
                self.assertFalse(base.exists())

    def test_live_mostra_a_foto_e_leituras_atualizadas_sem_mudar_os_originais(self):
        with TemporaryDirectory() as pasta:
            foto = Path(pasta) / "latest.jpg"
            base = Path(pasta) / "montra.sqlite3"
            Image.new("RGB", (2, 2)).save(foto)
            os.utime(foto, (1795756380, 1795756380))
            with sqlite3.connect(base) as db:
                db.execute(
                    "CREATE TABLE projects_growboxreading "
                    "(id INTEGER PRIMARY KEY, measured_at TEXT, temperature_c REAL, humidity_percent REAL)"
                )
                db.execute(
                    "INSERT INTO projects_growboxreading VALUES (1, '2026-11-27 05:12:00', 19.5, 83.4)"
                )
            with self.settings(MYCOLAB_LIVE_PHOTO=foto, MYCOLAB_LIVE_READINGS=base):
                painel = self.client.get("/en/mycobox/live/")
                self.assertContains(painel, 'data-live-url="/en/mycobox/live/dados/"')
                self.assertContains(painel, 'data-live-foto-url="/en/mycobox/live/foto/estado/"')
                self.assertContains(painel, 'data-live-proxima="1795756980"')
                self.assertContains(painel, "19.5 °C")
                self.assertContains(painel, "83.4 %")
                self.assertContains(painel, '<time datetime="2026-11-27T06:12:00+01:00">')
                imagem = self.client.get("/en/mycobox/live/foto/")
                self.assertEqual(imagem.headers["Content-Type"], "image/jpeg")
                self.assertEqual(b"".join(imagem.streaming_content), foto.read_bytes())
                with db:
                    db.execute(
                        "INSERT INTO projects_growboxreading VALUES (2, '2026-11-27 05:13:00', 20.1, 84.2)"
                    )
                os.utime(foto, (1795756440, 1795756440))
                dados = self.client.get("/en/mycobox/live/dados/")
                self.assertContains(dados, "20.1 °C")
                self.assertContains(dados, "84.2 %")
                self.assertContains(dados, 'src="/en/mycobox/live/foto/?v=1795756440000000000"')
                self.assertContains(dados, 'data-live-proxima="1795757040"')
                self.assertNotContains(dados, "<h1>")
                self.assertIn("no-store", dados.headers["Cache-Control"])
                estado = self.client.get("/en/mycobox/live/foto/estado/")
                self.assertEqual(estado.json(), {"versao": "1795756440000000000"})
                self.assertIn("no-store", estado.headers["Cache-Control"])
                caixa = self.client.get("/en/mycobox/")
                self.assertContains(caixa, 'src="/en/mycobox/live/foto/?v=1795756440000000000"')
            db.close()

    def test_painel_exterior_graficos_e_intervalo_entre_fotografias(self):
        inicio = datetime.now(timezone.utc).replace(microsecond=0) - timedelta(minutes=10)
        with TemporaryDirectory() as pasta:
            foto = Path(pasta) / "latest.jpg"
            base = Path(pasta) / "montra.sqlite3"
            Image.new("RGB", (2, 2)).save(foto)
            with sqlite3.connect(base) as db:
                db.execute(
                    "CREATE TABLE projects_growboxreading (id INTEGER PRIMARY KEY, measured_at TEXT,"
                    " temperature_c REAL, humidity_percent REAL, external_temperature_c REAL,"
                    " external_humidity_percent REAL, fan_on BOOLEAN, humidifier_on BOOLEAN)"
                )
                for minuto, ventoinha, humidificador in ((0, 0, 0), (1, 1, 0), (2, 1, 1), (3, 0, 0)):
                    instante = inicio + timedelta(minutes=minuto)
                    db.execute(
                        "INSERT INTO projects_growboxreading VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                        (
                            minuto + 1, instante.replace(tzinfo=None).isoformat(sep=" "),
                            20.5, 80.9, 12.3, 49.7, ventoinha, humidificador,
                        ),
                    )
            db.close()
            with self.settings(MYCOLAB_LIVE_PHOTO=foto, MYCOLAB_LIVE_READINGS=base):
                capturas = (inicio, inicio + timedelta(minutes=3))
                for captura in capturas:
                    os.utime(foto, (captura.timestamp(), captura.timestamp()))
                    registar_fotografia()
                registar_fotografia()
                painel = self.client.get("/en/mycobox/live/")
                self.assertContains(painel, "12.3 °C")
                self.assertContains(painel, "49.7 %")
                self.assertContains(painel, "Next scheduled photo")
                self.assertContains(painel, "00:02:00")
                self.assertContains(painel, "00:01:00")
                self.assertNotContains(painel, "partial record")
                self.assertContains(painel, "Last 24 hours")
                self.assertContains(painel, 'data-live-grafico="temperatura"')
                self.assertContains(painel, 'data-live-grafico="humidade"')
                self.assertContains(painel, 'id="live-historico-dados"')
