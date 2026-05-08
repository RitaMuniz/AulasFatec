<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Solicitar Troca – Livraria</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
    <style>
        .secao { background:#fff; border:1px solid #e0d6c8; border-radius:8px;
                 padding:25px; max-width:600px; }
        .secao h3 { font-size:18px; border-bottom:1px solid #eee;
                    padding-bottom:10px; margin-bottom:15px; }
        .item-resumo { background:#fdf5ec; border:1px solid #e0d6c8; border-radius:6px;
                       padding:14px; margin-bottom:20px; }
        .item-resumo strong { display:block; font-size:15px; margin-bottom:4px; }
        .item-resumo span   { font-size:13px; color:#666; }
        .campo label    { display:block; font-weight:bold; margin-bottom:6px; }
        .campo textarea { width:100%; padding:10px; border:1px solid #ccc;
                          border-radius:4px; font-size:14px; resize:vertical;
                          box-sizing:border-box; }
        .aviso { background:#fff3cd; border:1px solid #ffc107; border-radius:4px;
                 padding:12px; margin-bottom:15px; font-size:14px; }
    </style>
</head>
<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a href="${pageContext.request.contextPath}/view/index.jsp">Início</a>
        <a href="${pageContext.request.contextPath}/pedidos">Meus Pedidos</a>
        <a href="${pageContext.request.contextPath}/troca">Minhas Trocas</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </div>
</header>

<div class="container">
    <h2 style="margin-bottom:24px;">Solicitar Troca</h2>

    <c:if test="${not empty erro}">
        <div class="aviso">⚠️ ${erro}</div>
    </c:if>

    <div class="secao">
        <h3>Pedido #${pedido.id}</h3>

        <div class="item-resumo">
            <strong>${item.livro.titulo}</strong>
            <span>
                Autor: ${item.livro.autor} &nbsp;|&nbsp;
                Qtd: ${item.quantidade} &nbsp;|&nbsp;
                Valor: R$ <fmt:formatNumber value="${item.subtotal}"
                            minFractionDigits="2" maxFractionDigits="2"/>
            </span>
        </div>

        <p style="font-size:13px; color:#555; margin-bottom:18px;">
            Após o recebimento do item pela loja, um <strong>cupom de troca</strong>
            no valor de
            <strong>R$ <fmt:formatNumber value="${item.subtotal}"
                         minFractionDigits="2" maxFractionDigits="2"/></strong>
            será gerado automaticamente para você.
        </p>

        <form action="${pageContext.request.contextPath}/troca" method="post">
            <input type="hidden" name="action"       value="solicitar">
            <input type="hidden" name="pedidoId"     value="${pedido.id}">
            <input type="hidden" name="itemPedidoId" value="${item.id}">

            <div class="campo" style="margin-bottom:20px;">
                <label for="motivo">Motivo da troca:</label>
                <textarea name="motivo" id="motivo" rows="4" required
                          placeholder="Ex: produto chegou danificado, edição diferente da anunciada..."></textarea>
            </div>

            <div style="display:flex; gap:12px;">
                <button type="submit" class="btn">Confirmar Solicitação</button>
                <a href="${pageContext.request.contextPath}/pedidos?id=${pedido.id}"
                   class="btn" style="background:#888;">Cancelar</a>
            </div>
        </form>
    </div>
</div>

<footer>© 2026 Livraria</footer>
</body>
</html>
