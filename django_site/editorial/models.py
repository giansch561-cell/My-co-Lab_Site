from django.core.validators import FileExtensionValidator
from django.db import models
from django.urls import reverse


class Pagina(models.Model):
    class Secao(models.TextChoices):
        INICIO = "inicio", "Início"
        SOBRE = "sobre", "Sobre"
        ARTIGOS = "artigos", "À volta dos cogumelos"
        COGUMELOS = "cogumelos", "Cogumelos"
        CULTIVO = "cultivo", "Cultivo"
        MYCOBOX = "mycobox", "MycoBox"

    secao = models.CharField("secção", max_length=12, choices=Secao.choices, unique=True)
    introducao = models.TextField("introdução", blank=True)
    texto = models.TextField(blank=True)
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


class Ficha(models.Model):
    titulo = models.CharField("título", max_length=160)
    slug = models.SlugField("identificador no endereço", max_length=160, unique=True)
    resumo = models.TextField(blank=True)
    imagem = models.ImageField(upload_to="fichas/", blank=True)
    imagem_alt = models.CharField("texto alternativo da imagem", max_length=180, blank=True)
    ordem = models.PositiveIntegerField(default=0)
    publicado = models.BooleanField(default=False)

    class Meta:
        abstract = True
        ordering = ("ordem", "titulo", "pk")

    def __str__(self):
        return self.titulo


class Artigo(Ficha):
    texto = models.TextField(blank=True)

    def get_absolute_url(self):
        return reverse("editorial:artigo", kwargs={"slug": self.slug})


class MetodoCultivo(Ficha):
    preco = models.CharField("preço do guia", max_length=30, blank=True)
    url_compra = models.URLField("ligação para compra", blank=True)
    mostrar_mycobox = models.BooleanField("incluir ligação para a MycoBox", default=False)

    class Meta(Ficha.Meta):
        verbose_name = "método de cultivo"
        verbose_name_plural = "métodos de cultivo"

    def get_absolute_url(self):
        return reverse("editorial:metodo", kwargs={"slug": self.slug})


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
