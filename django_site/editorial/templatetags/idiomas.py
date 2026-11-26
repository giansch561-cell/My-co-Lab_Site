from django import template
from django.urls import translate_url
from django.utils.translation import get_language

register = template.Library()


@register.simple_tag
def endereco_no_idioma(endereco, idioma):
    return translate_url(endereco, idioma)


@register.filter
def texto_localizado(objeto, campo):
    idioma = get_language()
    if idioma in ("de", "en"):
        traducao = getattr(objeto, f"{campo}_{idioma}", "")
        if traducao.strip():
            return traducao
    return getattr(objeto, campo, "")
