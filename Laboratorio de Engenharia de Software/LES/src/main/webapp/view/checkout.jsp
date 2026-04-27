<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout – Livraria</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
    <style>
        .checkout-grid { display:grid; grid-template-columns:2fr 1fr; gap:30px; align-items:start; }
        .secao { background:#fff; border:1px solid #e0d6c8; border-radius:8px; padding:25px; margin-bottom:20px; }
        .secao h3 { margin-bottom:15px; font-size:18px; border-bottom:1px solid #eee; padding-bottom:10px; }
        .campo { margin-bottom:15px; }
        .campo label { display:block; margin-bottom:5px; font-weight:bold; font-size:14px; }
        .campo select, .campo input[type=number], .campo input[type=text] {
            width:100%; padding:10px; border:1px solid #ccc; border-radius:4px;
            font-size:14px; box-sizing:border-box;
        }
        .cartao-bloco { border:1px solid #ddd; border-radius:6px; padding:15px; margin-bottom:10px; }
        .cartao-bloco.opcional { background:#fafafa; }
        #bloco-cartao2 { display:none; }

        .cupom-lista { display:flex; flex-direction:column; gap:8px; }
        .cupom-item  { display:flex; align-items:center; gap:10px; padding:10px;
                       border:1px solid #e0d6c8; border-radius:6px; cursor:pointer; }
        .cupom-item input[type=checkbox] { width:18px; height:18px; cursor:pointer; }
        .cupom-item label { cursor:pointer; flex:1; font-size:14px; margin:0; font-weight:normal; }
        .cupom-item.selecionado { border-color:#6b4c2a; background:#fdf5ec; }
        .tag-tipo { font-size:11px; padding:2px 7px; border-radius:10px; font-weight:bold; }
        .tag-troca      { background:#e8f5e9; color:#2e7d32; }
        .tag-promocional{ background:#e3f2fd; color:#1565c0; }

        .resumo-linha { display:flex; justify-content:space-between; padding:6px 0; font-size:15px; }
        .resumo-linha.total { font-weight:bold; font-size:17px; border-top:2px solid #333;
                               margin-top:8px; padding-top:10px; }
        .btn-finalizar { width:100%; padding:14px; font-size:16px; margin-top:15px; }
        .aviso  { border-radius:4px; padding:10px; font-size:13px; margin-top:8px; }
        .aviso.warn  { background:#fff3cd; border:1px solid #ffc107; }
        .aviso.erro  { background:#fdecea; border:1px solid #e53935; }
        .aviso.info  { background:#e8f5e9; border:1px solid #43a047; }

        #r-frete { font-style:italic; color:#777; }
    </style>
</head>
<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a href="${pageContext.request.contextPath}/view/index.jsp">Início</a>
        <a href="${pageContext.request.contextPath}/livros">Livros</a>
        <a href="${pageContext.request.contextPath}/view/cliente.jsp">${sessionScope.clienteLogado.nome}</a>
        <a href="${pageContext.request.contextPath}/carrinho">Carrinho</a>
    </div>
</header>

<div class="container">
    <h2 style="margin-bottom:30px;">Finalizar Compra</h2>

    <%-- Erro vindo de redirect do controller --%>
    <c:if test="${not empty sessionScope.erroCheckout}">
        <div class="aviso erro">⚠️ ${sessionScope.erroCheckout}</div>
        <% session.removeAttribute("erroCheckout"); %>
    </c:if>

    <form action="${pageContext.request.contextPath}/pedido" method="post" id="formCheckout">
    <div class="checkout-grid">

        <%-- ==================== COLUNA ESQUERDA ==================== --%>
        <div>

            <%-- ENDEREÇO --%>
            <div class="secao">
                <h3>Endereço de Entrega</h3>
                <c:choose>
                    <c:when test="${empty enderecos}">
                        <p>Você não tem endereços cadastrados.
                           <a href="${pageContext.request.contextPath}/endereco?action=listar&amp;origem=checkout">Cadastrar endereço</a>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div class="campo">
                            <label>Selecione o endereço:</label>
                            <select name="endereco_id" id="endereco_id" data-test="endereco_id" required onchange="calcularFrete()">
                                <c:forEach var="e" items="${enderecos}">
                                    <option value="${e.id}" data-cep="${e.cep}">
                                        ${e.tipoLogradouro} ${e.logradouro}, ${e.numero}
                                        – ${e.bairro} – CEP ${e.cep}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:otherwise>
                </c:choose>
                <p style="margin-top:8px; font-size:13px;">
                    <a data-test="botao_cadastrar_endereco" href="${pageContext.request.contextPath}/endereco?action=listar&amp;origem=checkout">+ Cadastrar novo endereço</a>
                </p>
                <div class="campo">
                    <label>Frete estimado:</label>
                    <p id="r-frete" data-test="valor_frete_calculado"><strong>Calculando...</strong></p>
                </div>
            </div>

            <%-- PAGAMENTO CARTÃO --%>
            <div class="secao">
                <h3>Forma de Pagamento</h3>

                <c:if test="${empty cartoes}">
                    <p>Você não tem cartões cadastrados.
                       <a href="${pageContext.request.contextPath}/cartao?action=listar&amp;origem=checkout">Cadastrar cartão</a>
                    </p>
                </c:if>

                <c:if test="${not empty cartoes}">
                    <div class="cartao-bloco">
                        <p style="font-weight:bold; margin-bottom:10px;">Cartão 1 (obrigatório)</p>
                        <div class="campo">
                            <label>Cartão:</label>
                            <select name="cartao1_id" id="cartao1_id" data-test="cartao1_id" required onchange="atualizarResumo()">
                                <c:forEach var="c" items="${cartoes}">
                                    <option value="${c.id}" data-test="opcao-cartao-${c.id}">
                                        **** **** **** ${c.numero.length() > 4 ? c.numero.substring(c.numero.length()-4) : c.numero}
                                        – ${c.nomeImpresso}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="campo">
                            <label>Valor neste cartão (R$):</label>
                            <input type="number" name="valor_cartao1" data-test="input-valor-cartao-1" id="valor_cartao1"
                                   step="0.01" min="0.01" placeholder="Ex: 50.00"
                                   required oninput="atualizarResumo()">
                        </div>
                    </div>

                    <div style="margin-bottom:10px;">
                        <label>
                            <input type="checkbox" id="ativarCartao2" data-test="checkbox-cartao-2" onchange="toggleCartao2()">
                            Usar um segundo cartão
                        </label>
                    </div>

                    <div class="cartao-bloco opcional" id="bloco-cartao2">
                        <p style="font-weight:bold; margin-bottom:10px;">Cartão 2 (opcional)</p>
                        <div class="campo">
                            <label>Cartão:</label>
                            <select name="cartao2_id" id="cartao2_id" data-test="select-cartao-2" onchange="atualizarResumo()">
                                <option value="">— Selecione —</option>
                                <c:forEach var="c" items="${cartoes}">
                                    <option value="${c.id}">
                                        **** **** **** ${c.numero.length() > 4 ? c.numero.substring(c.numero.length()-4) : c.numero}
                                        – ${c.nomeImpresso}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="campo">
                            <label>Valor neste cartão (R$):</label>
                            <input type="number" name="valor_cartao2" id="valor_cartao2" data-test="input-valor-cartao-2"
                                   step="0.01" min="0" placeholder="Ex: 30.00"
                                   oninput="atualizarResumo()">
                        </div>
                    </div>

                    <div id="aviso-valor"  class="aviso warn" data-test="alerta-valor-cartoes" style="display:none;"></div>
                    <div id="aviso-minimo" class="aviso erro" data-test="alerta-minimo-cartao" style="display:none;"></div>
                </c:if>

                <p style="margin-top:8px; font-size:13px;">
                    <a data-test="botao_cadastrar_cartao" href="${pageContext.request.contextPath}/cartao?action=listar&amp;origem=checkout">+ Cadastrar novo cartão</a>
                </p>
            </div>

            <%-- CUPONS--%>
            <div class="secao">
                <h3>Cupons de Desconto</h3>
                <c:choose>
                    <c:when test="${empty cupons}">
                        <p>Você não possui cupons disponíveis.</p>
                    </c:when>
                    <c:otherwise>
                        <p style="font-size:13px; margin-bottom:10px; color:#555;">
                            Selecione um ou mais cupons. O valor não pode ultrapassar o total do pedido.
                        </p>
                        <div class="cupom-lista" id="cupom-lista">
                            <c:forEach var="cup" items="${cupons}">
                                <div class="cupom-item" id="cupom-item-${cup.id}"  data-test="item-cupom-${cup.id}" onclick="toggleCupom(${cup.id})">
                                    <input type="checkbox" name="cupom_id" value="${cup.id}"  data-test="cupom-${cup.id}"
                                           id="chk-cupom-${cup.id}"
                                           data-valor="${cup.valor}"
                                           data-tipo="${cup.tipo}"
                                           onchange="atualizarResumo()"
                                           onclick="event.stopPropagation()">
                                    <label for="chk-cupom-${cup.id}">
                                        <strong>${cup.codigo}</strong> —
                                        R$ <fmt:formatNumber value="${cup.valor}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </label>
                                    <span class="tag-tipo ${cup.tipo == 'TROCA' ? 'tag-troca' : 'tag-promocional'}">
                                        ${cup.tipo}
                                    </span>
                                </div>
                            </c:forEach>
                        </div>
                        <div id="aviso-cupom" class="aviso warn" data-test="alerta-cupom" style="display:none;"></div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div><%-- fim coluna esquerda --%>

        <%-- ==================== COLUNA DIREITA – RESUMO ==================== --%>
        <div class="secao" id="resumo-pedido">
            <h3>Resumo do Pedido</h3>

            <c:forEach var="item" items="${sessionScope.carrinho.itens}">
                <div class="resumo-linha">
                    <span>${item.livro.titulo} x${item.quantidade}</span>
                    <span>R$ <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
            </c:forEach>

            <div class="resumo-linha">
                <span>Subtotal</span>
                <span>R$ <fmt:formatNumber value="${subtotalCarrinho}" minFractionDigits="2" maxFractionDigits="2"/></span>
            </div>
            <div class="resumo-linha">
                <span>Frete</span>
                <span id="r-frete-resumo" data-test="resumo-frete">—</span>
            </div>
            <div class="resumo-linha">
                <span>Desconto (cupons)</span>
                <span id="r-desconto" data-test="resumo-desconto">R$ 0,00</span>
            </div>
            <div class="resumo-linha total">
                <span>Total</span>
                <span id="r-total" data-test="resumo-total">—</span>
            </div>

            <div id="aviso-troco" class="aviso info" data-test="alerta-cupom-troco" style="display:none;">
                💡 Seus cupons cobrem mais que o total. O valor excedente virará um <strong>cupom de troca</strong>!
            </div>

            <button type="submit" class="btn btn-finalizar" data-test="botao_finalizar" id="btn-finalizar"
                    <c:if test="${empty cartoes or empty enderecos}">disabled title="Cadastre endereço e cartão para continuar"</c:if>>
                Confirmar Pedido
            </button>

            <a href="${pageContext.request.contextPath}/carrinho" class="btn"  data-test="voltar-carrinho"
               style="width:100%; text-align:center; margin-top:10px; display:block;
                      box-sizing:border-box; background:#888;">
                Voltar ao Carrinho
            </a>
        </div>

    </div>
    </form>
</div>

<footer>© 2026 Livraria</footer>

<script>
//Constantes vindas do JSP
const SUBTOTAL = parseFloat("${subtotalCarrinho}") || 0;
const MINIMO_CARTAO = 10.00;

let freteAtual = 0;

//Utilitários
function fmt(val) {
    return "R$ " + val.toFixed(2).replace(".", ",");
}

function showAviso(id, msg) {
    const el = document.getElementById(id);
    if (!el) return;
    if (msg) { el.innerHTML = msg; el.style.display = "block"; }
    else      { el.style.display = "none"; }
}

// Cálculo de frete (simulado no front com mesma lógica do back)
// O frete definitivo é calculado pelo servidor;
function calcularFrete() {
    const sel = document.getElementById("endereco_id");
    if (!sel) return;
    const opt = sel.options[sel.selectedIndex];
    const cep = (opt.getAttribute("data-cep") || "").replace(/\D/g, "");

    let base = 25;
    if (cep.length >= 2) {
        const p = parseInt(cep.substring(0, 2));
        if      (p <= 19) base = 15;
        else if (p <= 28) base = 18;
        else if (p <= 38) base = 18;
        else if (p <= 48) base = 22;
        else if (p <= 65) base = 27;
        else if (p <= 68) base = 35;
        else if (p <= 69) base = 38;
        else if (p <= 76) base = 20;
        else if (p <= 79) base = 25;
        else if (p <= 87) base = 17;
        else if (p <= 89) base = 17;
        else if (p <= 99) base = 19;
    }

    freteAtual = base; // peso não disponível no front → usa só a base
    document.getElementById("r-frete").innerHTML = "<strong>" + fmt(freteAtual) + "</strong> – Entrega padrão (até 7 dias úteis)";

    atualizarResumo();
}

// Toggle visual do cupom
function toggleCupom(id) {
    const chk = document.getElementById("chk-cupom-" + id);
    const item = document.getElementById("cupom-item-" + id);
    chk.checked = !chk.checked;
    item.classList.toggle("selecionado", chk.checked);
    atualizarResumo();
}

// Atualização do resumo
function atualizarResumo() {
    const totalBruto = SUBTOTAL + freteAtual;

    // soma dos cupons selecionados
    let somaCupons = 0;
    document.querySelectorAll("input[name='cupom_id']:checked").forEach(chk => {
        somaCupons += parseFloat(chk.getAttribute("data-valor") || "0");
    });

    // Aviso: cupons ultrapassam total (troco vira cupom de troca)
    let descontoEfetivo = somaCupons;
    const temTroco = somaCupons > totalBruto + 0.001;
    if (temTroco) {
        descontoEfetivo = totalBruto;
        showAviso("aviso-cupom",
            "⚠️ Seus cupons (" + fmt(somaCupons) + ") ultrapassam o total do pedido. " +
            "O valor excedente de <strong>" + fmt(somaCupons - totalBruto) + "</strong> " +
            "será convertido em um cupom de troca.");
        showAviso("aviso-troco", "💡 Cupom de troca de <strong>" +
            fmt(somaCupons - totalBruto) + "</strong> será gerado automaticamente!");
    } else {
        showAviso("aviso-cupom", "");
        showAviso("aviso-troco", "");
    }

    const totalLiquido = Math.max(0, totalBruto - descontoEfetivo);

    // Atualiza resumo
    document.getElementById("r-frete-resumo").textContent = freteAtual > 0 ? fmt(freteAtual) : "—";
    document.getElementById("r-desconto").textContent = fmt(descontoEfetivo);
    document.getElementById("r-total").textContent = totalLiquido > 0 ? fmt(totalLiquido) : "R$ 0,00";

    // ── Validação dos cartões ────────────────────────────────────────────────
    const v1 = parseFloat(document.getElementById("valor_cartao1")?.value || "0") || 0;
    const ativo2 = document.getElementById("ativarCartao2")?.checked;
    const v2 = ativo2 ? (parseFloat(document.getElementById("valor_cartao2")?.value || "0") || 0) : 0;
    const soma = v1 + v2;

    let erroCartao = "";
    let erroMinimo = "";

    if (soma > 0 || totalLiquido > 0) {
        // Soma deve bater com total líquido (tolerância R$ 0,02)
        if (Math.abs(soma - totalLiquido) > 0.02) {
            erroCartao = "⚠️ A soma dos cartões (" + fmt(soma) + ") deve ser igual ao total: " + fmt(totalLiquido);
        }

        // Regra do mínimo por cartão
        if (ativo2 && totalLiquido >= 20 - 0.001) {
            // Dois cartões: cada um precisa de R$ 10,00 mínimo
            if (v1 > 0 && v1 < MINIMO_CARTAO - 0.001) {
                erroMinimo = "❌ O valor mínimo por cartão é R$ 10,00. Cartão 1 está com " + fmt(v1) + ".";
            } else if (v2 > 0 && v2 < MINIMO_CARTAO - 0.001) {
                erroMinimo = "❌ O valor mínimo por cartão é R$ 10,00. Cartão 2 está com " + fmt(v2) + ".";
            }
        }
        // Se totalLiquido < 10 (cupons cobriram quase tudo), um cartão pode ter valor menor — permitido.
    }

    showAviso("aviso-valor",  erroCartao);
    showAviso("aviso-minimo", erroMinimo);

    // Habilita/desabilita botão
    const podeFinalizarCartoes = !erroCartao && !erroMinimo;
    const btn = document.getElementById("btn-finalizar");
    if (btn && !btn.disabled) {
        btn.disabled = !podeFinalizarCartoes;
        btn.title = podeFinalizarCartoes ? "" : "Corrija os valores antes de finalizar.";
    }
}

// Toggle cartão 2
function toggleCartao2() {
    const bloco = document.getElementById("bloco-cartao2");
    const ativo = document.getElementById("ativarCartao2").checked;
    bloco.style.display = ativo ? "block" : "none";
    if (!ativo) {
        document.getElementById("valor_cartao2").value = "";
        document.getElementById("cartao2_id").value = "";
    }
    atualizarResumo();
}

// Validação no submit
document.getElementById("formCheckout").addEventListener("submit", function(e) {
    const totalBruto = SUBTOTAL + freteAtual;

    let somaCupons = 0;
    document.querySelectorAll("input[name='cupom_id']:checked").forEach(chk => {
        somaCupons += parseFloat(chk.getAttribute("data-valor") || "0");
    });

    const descontoEfetivo = Math.min(somaCupons, totalBruto);
    const totalLiquido = Math.max(0, totalBruto - descontoEfetivo);

    const v1 = parseFloat(document.getElementById("valor_cartao1")?.value || "0") || 0;
    const ativo2 = document.getElementById("ativarCartao2")?.checked;
    const v2 = ativo2 ? (parseFloat(document.getElementById("valor_cartao2")?.value || "0") || 0) : 0;
    const soma = v1 + v2;

    // Bloqueia se soma dos cartões ≠ total líquido
    if (Math.abs(soma - totalLiquido) > 0.02) {
        e.preventDefault();
        alert("A soma dos valores nos cartões deve ser igual ao total do pedido: " + fmt(totalLiquido));
        return;
    }

    // Bloqueia se dois cartões e algum < R$ 10 (exceto quando total < R$ 10)
    if (ativo2 && totalLiquido >= 10 - 0.001) {
        if (v1 < MINIMO_CARTAO - 0.001 || v2 < MINIMO_CARTAO - 0.001) {
            e.preventDefault();
            alert("O valor mínimo por cartão é R$ 10,00.");
            return;
        }
    }
});

//Init
document.addEventListener("DOMContentLoaded", function() {
    calcularFrete();

    // Sincroniza estilo dos cupons já marcados
    document.querySelectorAll("input[name='cupom_id']").forEach(chk => {
        const item = document.getElementById("cupom-item-" + chk.value);
        if (item) item.classList.toggle("selecionado", chk.checked);
    });

    // Pré-preenche cartão 1 com o total ao carregar (após calcularFrete rodar)
    setTimeout(() => {
        const v1 = document.getElementById("valor_cartao1");
        if (v1 && !v1.value && freteAtual > 0) {
            const total = SUBTOTAL + freteAtual;
            v1.value = total.toFixed(2);
            atualizarResumo();
        }
    }, 100);
});
</script>
</body>
</html>
