from django.conf import settings
from django.http import FileResponse, Http404, JsonResponse
from django.shortcuts import render
from django.views.decorators.cache import cache_control, never_cache
from django.views.generic import DetailView, ListView

from .live import estado_live, ultima_fotografia
from .models import Artigo, Cogumelo, Fonte, GuiaGrowBox, MetodoCultivo, Pagina, Timelapse


def inicio(request):
    secoes = (
        (Pagina.Secao.ARTIGOS, "editorial:artigos"),
        (Pagina.Secao.CULTIVO, "editorial:cultivo"),
        (Pagina.Secao.COGUMELOS, "editorial:cogumelos"),
    )
    paginas = Pagina.objects.in_bulk(field_name="secao")
    cartoes = [
        {"titulo": secao.label, "rota": rota, "pagina": paginas.get(secao)}
        for secao, rota in secoes
    ]
    cartoes.append({
        "titulo": Pagina.Secao.MYCOBOX.label,
        "rota": "editorial:mycobox",
        "pagina": paginas.get(Pagina.Secao.GROWBOX),
        "imagem_padrao": "editorial/growbox.webp",
    })
    recentes = []
    for modelo in (Artigo, Cogumelo, MetodoCultivo, GuiaGrowBox):
        recentes.extend(
            modelo.objects.filter(publicado=True, publicado_em__isnull=False)
            .order_by("-publicado_em", "-pk")[:3]
        )
    recentes.sort(key=lambda ficha: ficha.publicado_em, reverse=True)
    return render(
        request,
        "editorial/inicio.html",
        {
            "secao": "inicio",
            "pagina": paginas.get(Pagina.Secao.INICIO),
            "cartoes": cartoes,
            "recentes": recentes[:3],
        },
    )


def pagina(request, secao, titulo, imagem_padrao=""):
    return render(
        request,
        "editorial/pagina.html",
        {
            "secao": secao,
            "titulo": titulo,
            "pagina": Pagina.objects.filter(secao=secao).first(),
            "imagem_padrao": imagem_padrao,
            "foto_live": ultima_fotografia() if secao == Pagina.Secao.MYCOBOX else None,
        },
    )


def bibliografia(request):
    return render(
        request,
        "editorial/bibliografia.html",
        {"fontes": Fonte.objects.all(), "secao": "bibliografia"},
    )


def timelapses(request):
    return render(
        request,
        "editorial/timelapses.html",
        {
            "secao": "mycobox",
            "pagina": Pagina.objects.filter(secao=Pagina.Secao.MYCOBOX).first(),
            "timelapses": Timelapse.objects.all(),
        },
    )


@never_cache
def live(request, parcial=False):
    modelo = "editorial/live_dados.html" if parcial else "editorial/live.html"
    return render(
        request,
        modelo,
        {"secao": "mycobox", **estado_live()},
    )


@cache_control(private=True, max_age=60)
def fotografia_live(request):
    try:
        foto = settings.MYCOLAB_LIVE_PHOTO.open("rb")
    except OSError as erro:
        raise Http404 from erro
    return FileResponse(foto, content_type="image/jpeg")


@never_cache
def estado_fotografia_live(request):
    foto = ultima_fotografia()
    return JsonResponse({"versao": foto["versao"] if foto else None})


class CatalogoView(ListView):
    template_name = "editorial/catalogo.html"
    context_object_name = "fichas"
    paginate_by = 18
    secao_pagina = None

    def get_context_data(self, **kwargs):
        contexto = super().get_context_data(**kwargs)
        if self.secao_pagina is not None:
            contexto["pagina"] = Pagina.objects.filter(secao=self.secao_pagina).first()
        return contexto


class FichaView(DetailView):
    template_name = "editorial/ficha.html"
    context_object_name = "ficha"
