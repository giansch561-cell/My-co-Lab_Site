from django.contrib.auth import get_user_model
from django.test import TestCase

from .models import Artigo, Cogumelo, Pagina


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
