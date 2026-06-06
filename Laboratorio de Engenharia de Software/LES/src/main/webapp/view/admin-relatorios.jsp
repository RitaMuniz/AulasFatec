<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin - Relatórios</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
</head>

<body>

<header class="topbar">
    <h1>Relatórios</h1>
    <h2>Obs: não é possível exportar para pdf, item estático</h2>
    <div>
        <a href="${pageContext.request.contextPath}/home">Ver Loja</a>
        <a href="${pageContext.request.contextPath}/view/login.jsp">Sair</a>
    </div>
</header>

<div class="layout">

    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/view/admin.jsp">Dashboard</a>
            <a href="${pageContext.request.contextPath}/view/admin-pedidos.jsp">Pedidos</a>
            <a href="${pageContext.request.contextPath}/admin-livros">Livros</a>
            <a href="${pageContext.request.contextPath}/view/admin-clientes.jsp">Clientes</a>
            <a href="${pageContext.request.contextPath}/view/admin-devolucoes.jsp">Devoluções</a>
            <a href="${pageContext.request.contextPath}/admin-relatorios" class="active">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <h2>Relatório Geral</h2>

        <%-- Filtro por período --%>
        <form method="get" action="${pageContext.request.contextPath}/admin-relatorios">
            <div class="form-grid">
                <div>
                    <label>Data Inicial</label>
                    <input type="date" name="dataInicial" value="${dataInicial}">
                </div>
                <div>
                    <label>Data Final</label>
                    <input type="date" name="dataFinal" value="${dataFinal}">
                </div>
            </div>
            <div class="form-actions">
                <button type="submit">Gerar Relatório</button>
                <a href="${pageContext.request.contextPath}/admin-relatorios" class="btn-cancelar">Limpar</a>
            </div>
        </form>

        <%-- Cards de resumo --%>
        <div class="dashboard">

            <div class="card">
                <h3>Faturamento Total</h3>
                <p>
                    <fmt:setLocale value="pt_BR"/>
                    <fmt:formatNumber value="${faturamento}" type="currency" currencySymbol="R$"/>
                </p>
            </div>

            <div class="card">
                <h3>Total de Pedidos</h3>
                <p>${totalPedidos}</p>
            </div>

            <div class="card">
                <h3>Clientes Ativos</h3>
                <p>${clientesAtivos}</p>
            </div>

            <div class="card">
                <h3>Livro Mais Vendido</h3>
                <p>${empty livroTop ? '-' : livroTop}</p>
            </div>

        </div>

        <%-- Tabela de histórico de vendas --%>
        <h2>Histórico de Vendas</h2>

        <c:choose>
            <c:when test="${empty vendas}">
                <p>Nenhuma venda encontrada para o período selecionado.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                    <tr>
                        <th>Pedido</th>
                        <th>Cliente</th>
                        <th>Data</th>
                        <th>Valor</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="v" items="${vendas}">
                        <tr>
                            <td>#<fmt:formatNumber value="${v.id}" pattern="0000"/></td>
                            <td>${v.cliente}</td>
                            <td>${v.dataPedido}</td>
                            <td>
                                <fmt:formatNumber value="${v.valorTotal}" type="currency" currencySymbol="R$"/>
                            </td>
                            <td>${v.status}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

        <br>
        <button onclick="window.print()">Exportar PDF</button>

    </main>
</div>

<footer>
    Área Administrativa - Livraria &copy; 2026
</footer>

</body>
</html>
