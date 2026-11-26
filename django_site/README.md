# My-co-Lab em Django

Estrutura da primeira versão em português. Funciona como aplicação independente.
Os artigos, as fichas, os métodos de cultivo, os textos das páginas e a
bibliografia são editáveis na administração de Django.

## Abrir a versão local

Na pasta que contém `manage.py`, com Python 3.10 ou superior:

```bash
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -r requirements.txt
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

Abre `http://127.0.0.1:8000/` para ver o site e
`http://127.0.0.1:8000/admin/` para entrar na administração.

## Preencher depois

- **Páginas.** Escolhe a secção para acrescentar os seus textos e a imagem. Nas
  secções À volta dos cogumelos, Cultivo e Cogumelos, a imagem é usada no
  respetivo cartão do Início. O timelapse é apresentado na MycoBox.
- **Artigos, Cogumelos e Métodos de cultivo.** Cria as fichas como rascunho.
  Marca **Publicado** quando estiverem prontas. Nos cogumelos, o esboço aparece
  no catálogo e a fotografia na ficha individual.
- **Cultivo.** Acrescenta o preço e a ligação de compra quando o PDF estiver
  disponível. A ligação é apresentada quando ambos estiverem preenchidos.
- **Fontes.** Acrescenta as referências usadas. Aparecem na Bibliografia.

O servidor `runserver` serve a prévia local. A publicação tem configuração
própria. Se desativares a prévia com `DJANGO_DEBUG=0`, define
`DJANGO_SECRET_KEY` e `DJANGO_ALLOWED_HOSTS` no ambiente.
