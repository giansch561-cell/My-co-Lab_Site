from django.db import migrations


CAMPOS = (
    "introducao", "introducao_de", "introducao_en",
    "texto", "texto_de", "texto_en",
    "imagem", "imagem_alt", "imagem_alt_de", "imagem_alt_en",
)


def trocar_apresentacoes(apps, schema_editor):
    Pagina = apps.get_model("editorial", "Pagina")
    paginas = Pagina.objects.using(schema_editor.connection.alias)
    secoes = ("growbox", "mycobox")
    anteriores = {
        secao: dict(zip(CAMPOS, valores))
        for secao, *valores in paginas.filter(secao__in=secoes).values_list("secao", *CAMPOS)
    }
    vazios = dict.fromkeys(CAMPOS, "")
    for destino, origem in (secoes, secoes[::-1]):
        dados = anteriores.get(origem, vazios)
        if destino in anteriores or any(dados.values()):
            paginas.update_or_create(secao=destino, defaults=dados)


class Migration(migrations.Migration):
    dependencies = [("editorial", "0004_timelapses_mycobox")]

    operations = [
        migrations.RunPython(trocar_apresentacoes, trocar_apresentacoes),
    ]
