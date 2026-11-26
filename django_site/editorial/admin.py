from django.contrib import admin

from .models import Artigo, Cogumelo, Fonte, MetodoCultivo, Pagina


@admin.register(Pagina)
class PaginaAdmin(admin.ModelAdmin):
    list_display = ("secao",)


class FichaAdmin(admin.ModelAdmin):
    list_display = ("titulo", "publicado", "ordem")
    list_filter = ("publicado",)
    search_fields = ("titulo",)
    prepopulated_fields = {"slug": ("titulo",)}


admin.site.register([Artigo, Cogumelo, MetodoCultivo], FichaAdmin)
admin.site.register(Fonte)
