from django.urls import path

from . import views
from .models import Artigo, Cogumelo, MetodoCultivo

app_name = "editorial"

artigos = Artigo.objects.filter(publicado=True)
cogumelos = Cogumelo.objects.filter(publicado=True).select_related("metodo_cultivo")
metodos = MetodoCultivo.objects.filter(publicado=True)

urlpatterns = [
    path("", views.inicio, name="inicio"),
    path("sobre/", views.pagina, {"secao": "sobre", "titulo": "Como tudo começou"}, name="sobre"),
    path(
        "a-volta-dos-cogumelos/",
        views.CatalogoView.as_view(
            queryset=artigos,
            extra_context={"titulo": "À volta dos cogumelos", "secao": "artigos"},
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
            extra_context={"titulo": "Cogumelos", "secao": "cogumelos"},
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
            extra_context={"titulo": "Cultivo", "secao": "cultivo"},
        ),
        name="cultivo",
    ),
    path(
        "cultivo/<slug:slug>/",
        views.FichaView.as_view(queryset=metodos, extra_context={"secao": "cultivo"}),
        name="metodo",
    ),
    path(
        "mycobox/",
        views.pagina,
        {"secao": "mycobox", "titulo": "MycoBox", "imagem_padrao": "editorial/mycobox.webp"},
        name="mycobox",
    ),
    path("bibliografia/", views.bibliografia, name="bibliografia"),
]
