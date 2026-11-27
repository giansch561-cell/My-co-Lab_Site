from datetime import datetime, timedelta, timezone

from django.contrib.auth import get_user_model
from django.test import TestCase

from .models import Artigo, Cogumelo, GuiaGrowBox, MetodoCultivo, Pagina


class IdiomasTest(TestCase):
    def test_paginas_e_navegacao_em_tres_idiomas(self):
        traducoes = (
            ("", "pt-pt", "Cogumelos"),
            ("/de", "de", "Pilze"),
            ("/en", "en", "Mushrooms"),
        )
        for prefixo, idioma, titulo in traducoes:
            with self.subTest(idioma=idioma):
                inicio = self.client.get(prefixo + "/")
                self.assertContains(inicio, f'href="{prefixo}/cogumelos/"')
                pagina = self.client.get(prefixo + "/cogumelos/")
                self.assertEqual(pagina.headers["Content-Language"], idioma)
                self.assertContains(pagina, f"<h1>{titulo}</h1>")
                for destino, codigo, _ in traducoes:
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


class PaginaInicialTest(TestCase):
    def test_ficha_growbox_leva_ao_catalogo_e_ao_guia_traduzido(self):
        guia = GuiaGrowBox.objects.create(
            titulo="Câmara e timelapse",
            titulo_en="Camera and time-lapse",
            slug="camara-e-timelapse",
            publicado=True,
            preco="9 CHF",
            url_compra="https://example.org/guia",
        )
        inicio = self.client.get("/")
        self.assertContains(inicio, 'class="cartao"', count=4)
        self.assertContains(inicio, 'href="/growbox/"')
        self.assertContains(inicio, "/static/editorial/growbox.webp")
        self.assertContains(self.client.get("/mycobox/"), 'href="/growbox/"')
        catalogo = self.client.get("/en/growbox/")
        self.assertContains(catalogo, "<h1>GrowBox</h1>")
        self.assertContains(catalogo, "Camera and time-lapse")
        self.assertContains(catalogo, 'href="/en/growbox/camara-e-timelapse/"')
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
