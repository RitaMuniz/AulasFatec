<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin – Detalhe do Pedido</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
</head>
<body>

<header class="topbar">
    <h1>Detalhe do Pedido #<fmt:formatNumber value="${pedido.id}" minIntegerDigits="4"/></h1>
    <div>
        <a href="${pageContext.request.contextPath}/admin/pedidos" data-test="button-voltar">Voltar</a>
        <a href="${pageContext.request.contextPath}/logout" data-test="button-sair">Sair</a>
    </div>
</header>

<div class="layout">
    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/admin" data-test="button-dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/pedidos" class="active" data-test="button-pedidos">Pedidos</a>
            <a href="${pageContext.request.contextPath}/view/admin-livros.html" data-test="button-livros">Livros</a>
            <a href="${pageContext.request.contextPath}/view/admin-clientes.jsp" data-test="button-clientes">Clientes</a>
            <a href="${pageContext.request.contextPath}/troca?action=admin" data-test="button-devolucoes">Devoluções</a>
            <a href="${pageContext.request.contextPath}/view/admin-relatorios.html" data-test="button-relatorio">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <h2>Informações do Pedido</h2>
        <table>
            <tr><th>Número</th><td data-test="pedido-numero-${pedido.id}">#<fmt:formatNumber value="${pedido.id}" minIntegerDigits="4"/></td></tr>
            <tr><th>Data</th><td data-test="pedido-data-${pedido.dataCriacao}"><fmt:formatDate value="${pedido.dataCriacao}" pattern="dd/MM/yyyy HH:mm"/></td></tr>
            <tr><th>Status</th><td data-test="pedido-numero-${pedido.status}">${pedido.status}</td></tr>
        </table>

        <br>

        <h2>Informações do Cliente</h2>
        <table>
            <tr><th>Nome</th><td data-test="cliente-nome-${pedido.cliente.nome}">${pedido.cliente.nome}</td></tr>
            <tr><th>Email</th><td data-test="cliente-email-${pedido.cliente.email}">${pedido.cliente.email}</td></tr>
            <tr><th>CPF</th><td data-test="cliente-cpf-${pedido.cliente.cpf}">${pedido.cliente.cpf}</td></tr>
        </table>

        <br>

        <h2>Itens do Pedido</h2>
        <table>
            <thead>
            <tr>
                <th>Livro</th>
                <th>Autor</th>
                <th>Quantidade</th>
                <th>Preço Unitário</th>
                <th>Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${pedido.itens}">
                <tr>
                    <td data-test="cliente-titulo-${item.livro.titulo}">${item.livro.titulo}</td>
                    <td data-test="cliente-autor-${item.livro.autor}">${item.livro.autor}</td>
                    <td data-test="cliente-quantidade-${item.livro.titulo}">${item.quantidade}</td>
                    <td data-test="cliente-precoUnitario-${item.precoUnitario}">R$ <fmt:formatNumber value="${item.precoUnitario}" minFractionDigits="2" maxFractionDigits="2"/></td>
                    <td data-test="cliente-subtotal-${item.subtotal}">R$ <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <br>

        <h2>Resumo Financeiro</h2>
        <table>
            <tr><th>Valor Total</th><td data-test="pedido-total-${pedido.total}"><strong>R$ <fmt:formatNumber value="${pedido.total}" minFractionDigits="2" maxFractionDigits="2"/></strong></td></tr>
        </table>

        <br>

        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/admin/pedidos?id=${pedido.id}&acao=editar" class="btn-editar" data-test="button-editar">Editar Pedido</a>
            <a href="${pageContext.request.contextPath}/admin/pedidos" class="btn-cancelar" data-test="button-voltar">Voltar</a>
        </div>

    </main>
</div>

<footer>Área Administrativa – Livraria © 2026</footer>
</body>
</html>
