from django.shortcuts import render
from django.views.generic import DetailView, ListView

from .models import Artigo, Cogumelo, Fonte, GuiaGrowBox, MetodoCultivo, Pagina


def inicio(request):
    secoes = (
        (Pagina.Secao.ARTIGOS, "editorial:artigos"),
        (Pagina.Secao.CULTIVO, "editorial:cultivo"),
        (Pagina.Secao.COGUMELOS, "editorial:cogumelos"),
        (Pagina.Secao.GROWBOX, "editorial:growbox"),
    )
    paginas = Pagina.objects.in_bulk(field_name="secao")
    cartoes = [
        {
            "titulo": secao.label,
            "rota": rota,
            "pagina": paginas.get(secao),
            "imagem_padrao": "editorial/growbox.webp" if secao == Pagina.Secao.GROWBOX else "",
        }
        for secao, rota in secoes
    ]
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
        },
    )


def bibliografia(request):
    return render(
        request,
        "editorial/bibliografia.html",
        {"fontes": Fonte.objects.all(), "secao": "bibliografia"},
    )


class CatalogoView(ListView):
    template_name = "editorial/catalogo.html"
    context_object_name = "fichas"
    paginate_by = 18


class FichaView(DetailView):
    template_name = "editorial/ficha.html"
    context_object_name = "ficha"
