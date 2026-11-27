from django.core.validators import FileExtensionValidator
from django.db import models
from django.urls import reverse
from django.utils import timezone
from django.utils.translation import gettext_lazy as _


class ConteudoTraduzivel(models.Model):
    imagem_alt_de = models.CharField("texto alternativo — alemão", max_length=180, blank=True)
    imagem_alt_en = models.CharField("texto alternativo — inglês", max_length=180, blank=True)

    class Meta:
        abstract = True


class Pagina(ConteudoTraduzivel):
    class Secao(models.TextChoices):
        INICIO = "inicio", _("Início")
        SOBRE = "sobre", _("Sobre")
        ARTIGOS = "artigos", _("À volta dos cogumelos")
        COGUMELOS = "cogumelos", _("Cogumelos")
        CULTIVO = "cultivo", _("Cultivo")
        MYCOBOX = "mycobox", "MycoBox"
        GROWBOX = "growbox", "GrowBox"

    secao = models.CharField("secção", max_length=12, choices=Secao.choices, unique=True)
    introducao = models.TextField("introdução", blank=True)
    introducao_de = models.TextField("introdução — alemão", blank=True)
    introducao_en = models.TextField("introdução — inglês", blank=True)
    texto = models.TextField(blank=True)
    texto_de = models.TextField("texto — alemão", blank=True)
    texto_en = models.TextField("texto — inglês", blank=True)
    imagem = models.ImageField(upload_to="paginas/", blank=True)
    imagem_alt = models.CharField("texto alternativo da imagem", max_length=180, blank=True)
    timelapse = models.FileField(
        "timelapse da MycoBox",
        upload_to="videos/",
        blank=True,
        validators=[FileExtensionValidator(["mp4", "webm"])],
    )

    class Meta:
        verbose_name = "página"
        verbose_name_plural = "páginas"

    def __str__(self):
        return self.get_secao_display()


class Ficha(ConteudoTraduzivel):
    titulo = models.CharField("título", max_length=160)
    titulo_de = models.CharField("título — alemão", max_length=160, blank=True)
    titulo_en = models.CharField("título — inglês", max_length=160, blank=True)
    slug = models.SlugField("identificador no endereço", max_length=160, unique=True)
    resumo = models.TextField(blank=True)
    resumo_de = models.TextField("resumo — alemão", blank=True)
    resumo_en = models.TextField("resumo — inglês", blank=True)
    imagem = models.ImageField(upload_to="fichas/", blank=True)
    imagem_alt = models.CharField("texto alternativo da imagem", max_length=180, blank=True)
    ordem = models.PositiveIntegerField(default=0)
    publicado = models.BooleanField(default=False)
    publicado_em = models.DateTimeField(
        "data de publicação",
        blank=True,
        null=True,
        help_text="Preenchida automaticamente na primeira publicação de uma ficha nova.",
    )

    class Meta:
        abstract = True
        ordering = ("ordem", "titulo", "pk")

    def __str__(self):
        return self.titulo

    def save(self, *args, **kwargs):
        campos = kwargs.get("update_fields")
        if self.publicado and self.publicado_em is None and (campos is None or "publicado" in campos):
            estava_publicado = self.pk is not None and type(self).objects.using(
                kwargs.get("using") or self._state.db
            ).filter(pk=self.pk, publicado=True).exists()
            if not estava_publicado:
                self.publicado_em = timezone.now()
                if campos is not None:
                    kwargs["update_fields"] = {*campos, "publicado_em"}
        super().save(*args, **kwargs)


class Artigo(Ficha):
    texto = models.TextField(blank=True)
    texto_de = models.TextField("texto — alemão", blank=True)
    texto_en = models.TextField("texto — inglês", blank=True)

    def get_absolute_url(self):
        return reverse("editorial:artigo", kwargs={"slug": self.slug})


class GuiaPago(Ficha):
    preco = models.CharField("preço do guia", max_length=30, blank=True)
    url_compra = models.URLField("ligação para compra", blank=True)

    class Meta(Ficha.Meta):
        abstract = True


class MetodoCultivo(GuiaPago):
    mostrar_mycobox = models.BooleanField("incluir ligação para a MycoBox", default=False)

    class Meta(Ficha.Meta):
        verbose_name = "método de cultivo"
        verbose_name_plural = "métodos de cultivo"

    def get_absolute_url(self):
        return reverse("editorial:metodo", kwargs={"slug": self.slug})


class GuiaGrowBox(GuiaPago):
    class Meta(GuiaPago.Meta):
        verbose_name = "guia GrowBox"
        verbose_name_plural = "guias GrowBox"

    def get_absolute_url(self):
        return reverse("editorial:guia_growbox", kwargs={"slug": self.slug})


class Cogumelo(Ficha):
    esboco = models.ImageField("esboço do catálogo", upload_to="esbocos/", blank=True)
    metodo_cultivo = models.ForeignKey(
        MetodoCultivo,
        verbose_name="método de cultivo",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="cogumelos",
    )

    def get_absolute_url(self):
        return reverse("editorial:cogumelo", kwargs={"slug": self.slug})


class Fonte(models.Model):
    titulo = models.CharField("título", max_length=200)
    referencia = models.CharField("dados da referência", max_length=300, blank=True)
    url = models.URLField("ligação", blank=True)

    class Meta:
        ordering = ("titulo", "pk")

    def __str__(self):
        return self.titulo
