<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Pedido #${pedido.id} – Livraria</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a href="${pageContext.request.contextPath}/view/index.jsp">Início</a>
        <a href="${pageContext.request.contextPath}/livros">Livros</a>
        <a href="${pageContext.request.contextPath}/pedidos">Meus Pedidos</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </div>
</header>

<div class="container">

    <h2 data-test="detalhe-pedido-numero">Pedido #<fmt:formatNumber value="${pedido.id}" minIntegerDigits="4"/></h2>

    <%-- Barra de status --%>
    <div class="status-bar" data-test="status-bar-pedido">
        <div class="step ${pedido.status == 'EM_PROCESSAMENTO' or pedido.status == 'CONFIRMADO' or pedido.status == 'SEPARANDO' or pedido.status == 'ENVIADO' or pedido.status == 'ENTREGUE' ? '' : 'inactive'}" data-test="status-confirmado">
            <div class="circle"></div>
            Confirmado
        </div>
        <div class="step ${pedido.status == 'SEPARANDO' or pedido.status == 'ENVIADO' or pedido.status == 'ENTREGUE' ? '' : 'inactive'}" data-test="status-separando">
            <div class="circle"></div>
            Separando
        </div>
        <div class="step ${pedido.status == 'ENVIADO' or pedido.status == 'ENTREGUE' ? '' : 'inactive'}" data-test="status-enviado">
            <div class="circle"></div>
            Enviado
        </div>
        <div class="step ${pedido.status == 'ENTREGUE' ? '' : 'inactive'}" data-test="status-entregue">
            <div class="circle"></div>
            Entregue
        </div>
    </div>

    <%-- Itens --%>
    <div class="pedidos-card">
        <h3>Itens do Pedido</h3>
        <c:forEach var="item" items="${itens}">
            <div style="display:flex; justify-content:space-between; padding:8px 0; border-bottom:1px solid #eee;">
                <div>
                    <strong>${item.livro.titulo}</strong><br>
                    <small>${item.livro.autor}</small>
                </div>
                <div style="text-align:right;">
                    <span>Qtd: ${item.quantidade}</span><br>
                    <span>R$ <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
            </div>
        </c:forEach>

        <div style="text-align:right; margin-top:15px;">
            <p data-test="detalhe-pedido-total">Total do Pedido: <strong>R$ <fmt:formatNumber value="${pedido.total}" minFractionDigits="2" maxFractionDigits="2"/></strong></p>
        </div>
    </div>

    <%-- Devolução --%>
    <div class="pedidos-card">
        <h3>Solicitar Devolução</h3>
        <c:choose>
            <c:when test="${pedido.status == 'ENTREGUE'}">
                <form action="${pageContext.request.contextPath}/devolucao" method="post">
                    <input type="hidden" name="pedido_id" value="${pedido.id}">
                    <p>
                        <label><input type="radio" name="motivo" value="DANIFICADO" required> Produto danificado</label><br>
                        <label><input type="radio" name="motivo" value="ARREPENDIMENTO"> Arrependimento</label><br>
                        <label><input type="radio" name="motivo" value="INCORRETO"> Pedido incorreto</label>
                    </p>
                    <button type="submit" class="btn">Enviar Solicitação</button>
                </form>
            </c:when>
            <c:otherwise>
                <p style="color:#888;">A solicitação de devolução estará disponível após a entrega do pedido.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <a href="${pageContext.request.contextPath}/pedidos" class="btn" style="margin-top:20px; display:inline-block;">
        ← Voltar aos Pedidos
    </a>

</div>

<footer>© 2026 Livraria</footer>
</body>
</html>
