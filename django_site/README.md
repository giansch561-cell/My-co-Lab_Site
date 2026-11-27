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
  secções À volta dos cogumelos, Cultivo, Cogumelos e GrowBox, a imagem é usada no
  respetivo cartão do Início. O timelapse é apresentado na MycoBox.
- **Artigos, Cogumelos, Métodos de cultivo e Guias GrowBox.** Cria as fichas como rascunho.
  Marca **Publicado** quando estiverem prontas. Nos cogumelos, o esboço aparece
  no catálogo e a fotografia na ficha individual.
- **Cultivo e GrowBox.** Acrescenta o preço e a ligação de compra quando o PDF estiver
  disponível. A ligação é apresentada quando ambos estiverem preenchidos.
- **Fontes.** Acrescenta as referências usadas. Aparecem na Bibliografia.
- **O que há de novo.** O Início mostra as três publicações mais recentes. A
  data é preenchida na primeira publicação. Para uma ficha já publicada
  antes desta atualização, indica a data original no campo **Data de publicação**.

## Idiomas

O seletor **PT · DE · EN** no cabeçalho abre a mesma página na língua escolhida.
O português mantém os endereços originais. As versões alemã e inglesa usam os
prefixos `/de/` e `/en/`.

No painel de administração, as páginas, os artigos, as fichas de cogumelos e os
métodos de cultivo têm secções **Alemão** e **Inglês**. Os campos por preencher
mostram o texto em português. As traduções do menu e dos botões já vêm com o site.
Depois de editar os ficheiros `.po` da interface, recompila-os com
`python manage.py compilemessages -l de -l en`, com GNU gettext instalado.

## MycoBox

A página **Timelapses** apresenta o vídeo da primeira colheita, quando já
carregado em **Páginas → MycoBox**, e os vídeos acrescentados em **Timelapses**.

A página **Live** verifica a cada minuto se chegaram uma nova fotografia ou uma
nova medição. Apresenta a hora de captura e a hora da leitura em separado.
No Raspberry Pi, reutiliza a fotografia que a Montra Digital recebe em
`~/.local/share/mycolab-growbox/latest.jpg` e lê a tabela
`projects_growboxreading` de `~/montra-digital/db.sqlite3` em modo só de leitura.
Para caminhos diferentes, define `MYCOLAB_LIVE_PHOTO` e
`MYCOLAB_LIVE_READINGS` no ambiente do serviço.

O servidor `runserver` serve a prévia local. A publicação tem configuração
própria. Se desativares a prévia com `DJANGO_DEBUG=0`, define
`DJANGO_SECRET_KEY` e `DJANGO_ALLOWED_HOSTS` no ambiente.
