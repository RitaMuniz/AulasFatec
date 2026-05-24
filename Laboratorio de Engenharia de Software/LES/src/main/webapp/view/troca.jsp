<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Minhas Trocas – Livraria</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
    <style>
        table { width:100%; border-collapse:collapse; background:#fff; border-radius:8px; overflow:hidden; }
        th { background:#6b4c2a; color:#fff; padding:12px; text-align:left; font-size:14px; }
        td { padding:12px; border-bottom:1px solid #eee; font-size:14px; }
        tr:last-child td { border-bottom:none; }
        .badge { padding:3px 10px; border-radius:12px; font-size:12px; font-weight:bold; }
        .SOLICITADA  { background:#fff3cd; color:#856404; }
        .APROVADA    { background:#cff4fc; color:#055160; }
        .RECEBIDA    { background:#d1e7dd; color:#0f5132; }
        .CONCLUIDA   { background:#d1e7dd; color:#0f5132; }
        .RECUSADA    { background:#f8d7da; color:#842029; }
        .aviso-sucesso { background:#d1e7dd; border:1px solid #badbcc; border-radius:6px;
                         padding:12px; margin-bottom:20px; color:#0f5132; }
    </style>
</head>
<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a data-test="button-inicio" href="${pageContext.request.contextPath}/home">Início</a>
        <a data-test="button-pedido" href="${pageContext.request.contextPath}/pedidos">Meus Pedidos</a>
        <a data-test="button-troca" href="${pageContext.request.contextPath}/troca">Minhas Trocas</a>
    </div>
</header>

<div class="container">
    <h2 style="margin-bottom:24px;">Minhas Trocas</h2>

    <c:if test="${param.sucesso == '1'}">
        <div data-test="aviso-sucesso" class="aviso-sucesso">
            ✅ Solicitação de troca enviada com sucesso! Acompanhe o status aqui.
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty trocas}">
            <p data-test="aviso-solicitacao" >Você não possui solicitações de troca.</p>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>#</th>
                    <th>Pedido</th>
                    <th>Solicitação</th>
                    <th>Status</th>
                    <th>Recebimento</th>
                    <th>Cupom Gerado</th>
                </tr>
                <c:forEach var="t" items="${trocas}">
                    <tr>
                        <td data-test="tabela-item-id-${t.id}">${t.id}</td>
                        <td data-test="tabela-item-pedido-${t.pedidoId}">#${t.pedidoId}</td>
                        <td data-test="tabela-item-dataSolicitacao-${t.dataSolicitacao}">${t.dataSolicitacao}</td>
                        <td data-test="tabela-item-status-${t.status}"><span class="badge ${t.status}">${t.status}</span></td>
                        <td data-test="tabela-item-dataRecebimento-${not empty t.dataRecebimento ? t.dataRecebimento : '—'}">${not empty t.dataRecebimento ? t.dataRecebimento : '—'}</td>
                        <td data-test="tabela-item-cupom-${not empty t.cupomGeradoId ? '✅ Cupom #'.concat(t.cupomGeradoId) : '—'}">${not empty t.cupomGeradoId ? '✅ Cupom #'.concat(t.cupomGeradoId) : '—'}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>

    <div style="margin-top:20px;">
        <a data-test="button-meus-pedidos" href="${pageContext.request.contextPath}/pedidos" class="btn">← Meus Pedidos</a>
    </div>
</div>

<footer>© 2026 Livraria</footer>
</body>
</html>