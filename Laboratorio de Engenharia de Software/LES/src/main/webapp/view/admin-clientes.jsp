<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin - Clientes</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
</head>

<body>

<header class="topbar">
    <h1>Gerenciar Clientes</h1>
    <div>
        <a href="index.jsp">Ver Loja</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </div>
</header>

<div class="layout">

    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a href="admin.html">Dashboard</a>
            <a href="admin-pedidos.html">Pedidos</a>
            <a href="admin-livros.html">Livros</a>
            <a href="${pageContext.request.contextPath}/cliente?action=listar" class="active">Clientes</a>
            <a href="admin-devolucoes.html">Devoluções</a>
            <a href="admin-relatorios.html">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <h2>Pesquisar Cliente</h2>

        <form action="${pageContext.request.contextPath}/cliente" method="get">
            <input type="hidden" name="action" value="listar">
            <div class="form-grid">
                <div>
                    <label>Buscar por nome, email ou CPF</label>
                    <input type="text" name="busca" placeholder="Ex: Maria Silva"
                           value="${param.busca}">
                </div>
            </div>
            <div class="form-actions">
                <button type="submit">Pesquisar</button>
                <a href="${pageContext.request.contextPath}/cliente?action=listar" class="btn-cancelar">Limpar</a>
            </div>
        </form>

        <h2>Lista de Clientes</h2>

        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Email</th>
                <th>CPF</th>
                <th>Status</th>
                <th>Ações</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty clientes}">
                    <tr>
                        <td colspan="6" style="text-align:center; color:#666;">
                            Nenhum cliente encontrado.
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="c" items="${clientes}">
                        <tr>
                            <td>${c.id}</td>
                            <td>${c.nome}</td>
                            <td>${c.email}</td>
                            <td>${c.cpf}</td>
                            <td>${c.status}</td>
                            <td class="acoes">
                                <c:choose>
                                    <c:when test="${c.status == 'ATIVO'}">
                                        <form action="${pageContext.request.contextPath}/cliente"
                                              method="post" style="display:inline;"
                                              onsubmit="return confirm('Desativar este cliente?')">
                                            <input type="hidden" name="action" value="desativar">
                                            <input type="hidden" name="id" value="${c.id}">
                                            <button class="btn-excluir">Desativar</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="${pageContext.request.contextPath}/cliente"
                                              method="post" style="display:inline;"
                                              onsubmit="return confirm('Reativar este cliente?')">
                                            <input type="hidden" name="action" value="reativar">
                                            <input type="hidden" name="id" value="${c.id}">
                                            <button class="btn-editar">Ativar</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

    </main>
</div>

<footer>
    Área Administrativa - Livraria © 2026
</footer>

</body>
</html>
