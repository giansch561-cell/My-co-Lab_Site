from django.conf import settings
from django.conf.urls.i18n import i18n_patterns
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path

admin.site.site_header = "Administração do My-co-Lab"
admin.site.site_title = "My-co-Lab"

urlpatterns = [
    path("admin/", admin.site.urls),
]
urlpatterns += i18n_patterns(
    path("", include("editorial.urls")),
    prefix_default_language=False,
)

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
