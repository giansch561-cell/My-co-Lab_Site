const painel = document.querySelector("[data-live-url]");
const intervaloDados = 60000;
const intervaloEspera = 5000;
const cores = ["#4c5e43", "#9d5b20"];
let proximaConsultaDados = Date.now() + intervaloDados;
let proximaConsultaFoto = 0;
let ultimaResposta;
let aConsultar = false;

function proximaFotografia() {
    return Number(painel.querySelector("[data-live-contador]").dataset.liveProxima) * 1000;
}

function versaoFotografia() {
    return painel.querySelector("[data-live-foto]")?.dataset.liveFoto || null;
}

function atualizarContador() {
    const contador = painel.querySelector("[data-live-contador]");
    const espera = painel.querySelector("[data-live-aguarda]");
    const segundos = Math.ceil((proximaFotografia() - Date.now()) / 1000);
    contador.hidden = segundos <= 0;
    espera.hidden = segundos > 0;
    if (segundos <= 0) {
        return;
    }
    const minutos = String(Math.floor(segundos / 60)).padStart(2, "0");
    const resto = String(segundos % 60).padStart(2, "0");
    contador.textContent = minutos + ":" + resto;
}

function desenharGrafico(canvas, dados) {
    const colunas = canvas.dataset.liveGrafico === "temperatura" ? [1, 3] : [2, 4];
    const valores = dados.flatMap(linha => colunas.map(coluna => linha[coluna])).filter(Number.isFinite);
    const largura = canvas.clientWidth;
    const altura = canvas.clientHeight;
    if (!valores.length || largura < 80 || altura < 80) {
        return;
    }
    const escala = window.devicePixelRatio || 1;
    canvas.width = largura * escala;
    canvas.height = altura * escala;
    const ctx = canvas.getContext("2d");
    ctx.scale(escala, escala);
    const esquerda = 42;
    const topo = 12;
    const fundo = altura - 25;
    const direita = largura - 22;
    const minimo = Math.floor(Math.min(...valores) - 1);
    const maximo = Math.ceil(Math.max(...valores) + 1);
    const fim = Date.now() / 1000;
    const inicio = fim - 86400;
    const x = instante => esquerda + (instante - inicio) / 86400 * (direita - esquerda);
    const y = valor => fundo - (valor - minimo) / (maximo - minimo) * (fundo - topo);
    const idioma = document.documentElement.lang;
    const formatoHora = new Intl.DateTimeFormat(idioma, { hour: "2-digit", minute: "2-digit" });

    ctx.font = "12px system-ui";
    ctx.fillStyle = "#413932";
    ctx.strokeStyle = "#ddd1bd";
    ctx.textAlign = "right";
    for (let i = 0; i <= 4; i += 1) {
        const valor = minimo + (maximo - minimo) * i / 4;
        ctx.beginPath();
        ctx.moveTo(esquerda, y(valor));
        ctx.lineTo(direita, y(valor));
        ctx.stroke();
        ctx.fillText(valor.toLocaleString(idioma, { maximumFractionDigits: 1 }), esquerda - 5, y(valor) + 4);
    }
    ctx.textAlign = "center";
    for (let i = 0; i <= 4; i += 1) {
        const instante = inicio + 86400 * i / 4;
        ctx.fillText(formatoHora.format(instante * 1000), x(instante), altura - 5, 46);
    }

    colunas.forEach((coluna, indice) => {
        ctx.strokeStyle = cores[indice];
        ctx.fillStyle = cores[indice];
        ctx.lineWidth = 2;
        let anterior;
        for (const linha of dados) {
            const instante = linha[0];
            const valor = linha[coluna];
            if (!Number.isFinite(valor) || instante < inicio || instante > fim) {
                anterior = undefined;
                continue;
            }
            ctx.beginPath();
            if (anterior && instante - anterior[0] <= 600) {
                ctx.moveTo(x(anterior[0]), y(anterior[coluna]));
                ctx.lineTo(x(instante), y(valor));
                ctx.stroke();
            } else {
                ctx.arc(x(instante), y(valor), 2, 0, Math.PI * 2);
                ctx.fill();
            }
            anterior = linha;
        }
    });
}

function desenharGraficos() {
    const fonte = document.getElementById("live-historico-dados");
    if (fonte) {
        const dados = JSON.parse(fonte.textContent);
        painel.querySelectorAll("[data-live-grafico]").forEach(grafico => desenharGrafico(grafico, dados));
    }
}

async function carregarDados() {
    const resposta = await fetch(painel.dataset.liveUrl, { cache: "no-store" });
    if (!resposta.ok) {
        return;
    }
    const dados = await resposta.text();
    if (dados === ultimaResposta) {
        return;
    }

    const fragmento = document.createElement("template");
    fragmento.innerHTML = dados;
    const foto = fragmento.content.querySelector("[data-live-foto]");
    if (foto && foto.dataset.liveFoto !== versaoFotografia()) {
        const imagem = new Image();
        imagem.src = foto.getAttribute("src");
        await imagem.decode();
    }

    painel.replaceChildren(fragmento.content);
    ultimaResposta = dados;
    atualizarContador();
    desenharGraficos();
}

async function atualizarLive() {
    const agora = Date.now();
    const atualizarDados = agora >= proximaConsultaDados;
    const verificarFoto = agora >= proximaFotografia() && agora >= proximaConsultaFoto;
    if (document.hidden || aConsultar || (!atualizarDados && !verificarFoto)) {
        return;
    }

    aConsultar = true;
    try {
        if (atualizarDados) {
            proximaConsultaDados = agora + intervaloDados;
            await carregarDados();
        } else {
            proximaConsultaFoto = agora + intervaloEspera;
            const resposta = await fetch(painel.dataset.liveFotoUrl, { cache: "no-store" });
            if (resposta.ok) {
                const { versao } = await resposta.json();
                if (versao && versao !== versaoFotografia()) {
                    await carregarDados();
                }
            }
        }
    } catch {
        // Volta a tentar na próxima atualização.
    } finally {
        aConsultar = false;
    }
}

atualizarContador();
desenharGraficos();
window.addEventListener("resize", desenharGraficos);
document.addEventListener("visibilitychange", atualizarLive);
window.setInterval(() => {
    atualizarContador();
    atualizarLive();
}, 1000);
