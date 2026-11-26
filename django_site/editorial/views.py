from django.shortcuts import render
from django.views.generic import DetailView, ListView

from .models import Fonte, Pagina


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
    return render(
        request,
        "editorial/inicio.html",
        {"secao": "inicio", "pagina": paginas.get(Pagina.Secao.INICIO), "cartoes": cartoes},
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
