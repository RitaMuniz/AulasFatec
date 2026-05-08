<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin – Editar Pedido</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
</head>
<body>

<header class="topbar">
    <h1>Editar Pedido #<fmt:formatNumber value="${pedido.id}" minIntegerDigits="4"/></h1>
    <div>
        <a href="${pageContext.request.contextPath}/admin/pedidos">Voltar</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </div>
</header>

<div class="layout">
    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/pedidos" class="active">Pedidos</a>
            <a href="${pageContext.request.contextPath}/view/admin-livros.html">Livros</a>
            <a href="${pageContext.request.contextPath}/view/admin-clientes.jsp">Clientes</a>
            <a href="${pageContext.request.contextPath}/troca?action=admin">Devoluções</a>
            <a href="${pageContext.request.contextPath}/view/admin-relatorios.html">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <form action="${pageContext.request.contextPath}/admin/pedidos" method="post">
            <input type="hidden" name="pedido_id" value="${pedido.id}">

            <h2>Dados do Cliente</h2>
            <div class="form-grid">
                <div>
                    <label>Nome:</label>
                    <input type="text" value="${pedido.cliente.nome}" readonly>
                </div>
                <div>
                    <label>Email:</label>
                    <input type="email" value="${pedido.cliente.email}" readonly>
                </div>
                <div>
                    <label>CPF:</label>
                    <input type="text" value="${pedido.cliente.cpf}" readonly>
                </div>
            </div>

            <h2>Status do Pedido</h2>
            <label>Status:</label>
            <select name="status">
                <option value="EM_PROCESSAMENTO" ${pedido.status == 'EM_PROCESSAMENTO' ? 'selected' : ''}>Em Processamento</option>
                <option value="CONFIRMADO"        ${pedido.status == 'CONFIRMADO'        ? 'selected' : ''}>Confirmado</option>
                <option value="SEPARANDO"         ${pedido.status == 'SEPARANDO'         ? 'selected' : ''}>Separando</option>
                <option value="ENVIADO"           ${pedido.status == 'ENVIADO'           ? 'selected' : ''}>Enviado</option>
                <option value="ENTREGUE"          ${pedido.status == 'ENTREGUE'          ? 'selected' : ''}>Entregue</option>
                <option value="CANCELADO"         ${pedido.status == 'CANCELADO'         ? 'selected' : ''}>Cancelado</option>
            </select>

            <h2>Itens do Pedido</h2>
            <table>
                <thead>
                <tr>
                    <th>Livro</th>
                    <th>Quantidade</th>
                    <th>Preço Unitário</th>
                    <th>Subtotal</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${pedido.itens}">
                    <tr>
                        <td>${item.livro.titulo}</td>
                        <td>${item.quantidade}</td>
                        <td>R$ <fmt:formatNumber value="${item.precoUnitario}" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td>R$ <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <h2>Total</h2>
            <p><strong>R$ <fmt:formatNumber value="${pedido.total}" minFractionDigits="2" maxFractionDigits="2"/></strong></p>

            <div class="form-actions">
                <button type="submit">Salvar Alterações</button>
                <a href="${pageContext.request.contextPath}/admin/pedidos?id=${pedido.id}" class="btn-cancelar">Cancelar</a>
            </div>

        </form>

    </main>
</div>

<footer>Área Administrativa – Livraria © 2026</footer>
</body>
</html>
