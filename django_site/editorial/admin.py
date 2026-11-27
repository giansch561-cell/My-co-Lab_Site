from django.contrib import admin

from .models import Artigo, Cogumelo, Fonte, GuiaGrowBox, MetodoCultivo, Pagina


class AdminComTraducoes(admin.ModelAdmin):
    def get_fieldsets(self, request, obj=None):
        campos = self.get_fields(request, obj)
        return (
            ("Português e definições comuns", {
                "fields": [campo for campo in campos if not campo.endswith(("_de", "_en"))],
            }),
            ("Alemão", {
                "fields": [campo for campo in campos if campo.endswith("_de")],
                "classes": ("collapse",),
            }),
            ("Inglês", {
                "fields": [campo for campo in campos if campo.endswith("_en")],
                "classes": ("collapse",),
            }),
        )


@admin.register(Pagina)
class PaginaAdmin(AdminComTraducoes):
    list_display = ("secao",)


class FichaAdmin(AdminComTraducoes):
    list_display = ("titulo", "publicado", "publicado_em", "ordem")
    list_filter = ("publicado",)
    search_fields = ("titulo", "titulo_de", "titulo_en")
    prepopulated_fields = {"slug": ("titulo",)}


admin.site.register([Artigo, Cogumelo, MetodoCultivo, GuiaGrowBox], FichaAdmin)
admin.site.register(Fonte)
