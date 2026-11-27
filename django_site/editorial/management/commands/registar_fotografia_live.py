from django.core.management.base import BaseCommand

from editorial.live import registar_fotografia


class Command(BaseCommand):
    help = "Regista a hora das duas últimas fotografias recebidas para a página Live."

    def handle(self, *args, **options):
        registar_fotografia()
