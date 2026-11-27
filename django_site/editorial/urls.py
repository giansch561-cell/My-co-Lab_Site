from django.urls import path
from django.utils.translation import gettext_lazy as _

from . import views
from .models import Artigo, Cogumelo, GuiaGrowBox, MetodoCultivo, Pagina

app_name = "editorial"

artigos = Artigo.objects.filter(publicado=True)
cogumelos = Cogumelo.objects.filter(publicado=True).select_related("metodo_cultivo")
metodos = MetodoCultivo.objects.filter(publicado=True)
guias_growbox = GuiaGrowBox.objects.filter(publicado=True)

urlpatterns = [
    path("", views.inicio, name="inicio"),
    path("sobre/", views.pagina, {"secao": "sobre", "titulo": _("Como tudo começou")}, name="sobre"),
    path(
        "a-volta-dos-cogumelos/",
        views.CatalogoView.as_view(
            queryset=artigos,
            template_name="editorial/catalogo_abertura.html",
            secao_pagina=Pagina.Secao.ARTIGOS,
            extra_context={
                "titulo": _("À volta dos cogumelos"),
                "secao": "artigos",
                "introducao_padrao": _(
                    "Descobre o que é um cogumelo, como vive um fungo e como se forma um cogumelo."
                ),
                "imagem_padrao": "editorial/abertura-artigos.webp",
                "imagem_alt_padrao": _("Cogumelos entre musgo e folhas caídas no chão do bosque."),
            },
        ),
        name="artigos",
    ),
    path(
        "a-volta-dos-cogumelos/<slug:slug>/",
        views.FichaView.as_view(queryset=artigos, extra_context={"secao": "artigos"}),
        name="artigo",
    ),
    path(
        "cogumelos/",
        views.CatalogoView.as_view(
            queryset=cogumelos,
            template_name="editorial/catalogo_abertura.html",
            secao_pagina=Pagina.Secao.COGUMELOS,
            extra_context={
                "titulo": _("Cogumelos"),
                "secao": "cogumelos",
                "introducao_padrao": _(
                    "Explora as fichas para conhecer diferentes cogumelos, os seus habitats "
                    "e algumas curiosidades sobre cada um."
                ),
                "imagem_padrao": "editorial/abertura-cogumelos.webp",
                "imagem_alt_padrao": _("Mesa de estudo com cogumelos, livros ilustrados, cadernos e uma lupa."),
            },
        ),
        name="cogumelos",
    ),
    path(
        "cogumelos/<slug:slug>/",
        views.FichaView.as_view(queryset=cogumelos, extra_context={"secao": "cogumelos"}),
        name="cogumelo",
    ),
    path(
        "cultivo/",
        views.CatalogoView.as_view(
            queryset=metodos,
            template_name="editorial/catalogo_abertura.html",
            secao_pagina=Pagina.Secao.CULTIVO,
            extra_context={
                "titulo": _("Cultivo"),
                "secao": "cultivo",
                "introducao_padrao": _(
                    "Descobre diferentes formas de cultivar cogumelos. "
                    "Em cada ficha encontras uma breve explicação do método."
                ),
                "imagem_padrao": "editorial/abertura-cultivo.webp",
                "imagem_alt_padrao": _("Mãos de um adulto e de uma criança a colher shiitake de troncos."),
            },
        ),
        name="cultivo",
    ),
    path(
        "cultivo/<slug:slug>/",
        views.FichaView.as_view(queryset=metodos, extra_context={"secao": "cultivo"}),
        name="metodo",
    ),
    path(
        "growbox/",
        views.CatalogoView.as_view(
            queryset=guias_growbox,
            template_name="editorial/growbox.html",
            secao_pagina=Pagina.Secao.GROWBOX,
            extra_context={
                "titulo": "GrowBox",
                "secao": "growbox",
                "introducao_padrao": _(
                    "Aprende a montar a tua GrowBox por módulos, com guias sobre "
                    "câmara e timelapse, sensores, ventilação e humidificação."
                ),
                "imagem_padrao": "editorial/abertura-growbox.webp",
                "imagem_alt_padrao": _(
                    "Ilustração de uma GrowBox com cogumelos-ostra, câmara e sensor."
                ),
            },
        ),
        name="growbox",
    ),
    path(
        "growbox/<slug:slug>/",
        views.FichaView.as_view(queryset=guias_growbox, extra_context={"secao": "growbox"}),
        name="guia_growbox",
    ),
    path(
        "mycobox/",
        views.pagina,
        {"secao": "mycobox", "titulo": "MycoBox", "imagem_padrao": "editorial/mycobox.webp"},
        name="mycobox",
    ),
    path("mycobox/timelapses/", views.timelapses, name="timelapses"),
    path("mycobox/live/", views.live, name="live"),
    path("mycobox/live/dados/", views.live, {"parcial": True}, name="live_dados"),
    path("mycobox/live/foto/", views.fotografia_live, name="live_foto"),
    path("mycobox/live/foto/estado/", views.estado_fotografia_live, name="live_foto_estado"),
    path("bibliografia/", views.bibliografia, name="bibliografia"),
]
