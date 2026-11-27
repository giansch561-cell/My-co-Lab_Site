from django.urls import path
from django.utils.translation import gettext_lazy as _

from . import views
from .models import Artigo, Cogumelo, GuiaGrowBox, MetodoCultivo

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
            extra_context={"titulo": _("À volta dos cogumelos"), "secao": "artigos"},
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
            extra_context={"titulo": _("Cogumelos"), "secao": "cogumelos"},
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
            extra_context={"titulo": _("Cultivo"), "secao": "cultivo"},
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
            extra_context={"titulo": "GrowBox", "secao": "growbox"},
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
