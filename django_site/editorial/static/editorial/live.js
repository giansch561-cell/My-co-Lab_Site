const painel = document.querySelector("[data-live-url]");
let ultimaResposta;

async function atualizarLive() {
    try {
        if (!document.hidden) {
            const resposta = await fetch(painel.dataset.liveUrl, { cache: "no-store" });
            if (resposta.ok) {
                const dados = await resposta.text();
                if (dados !== ultimaResposta) {
                    painel.innerHTML = dados;
                    ultimaResposta = dados;
                }
            }
        }
    } catch {
        // Volta a tentar na próxima atualização.
    }
    window.setTimeout(atualizarLive, 60000);
}

window.setTimeout(atualizarLive, 60000);
