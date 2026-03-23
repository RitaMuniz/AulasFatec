<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Meus Cartões</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>

<header class="navbar">
    <div class="logo">Livraria</div>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/cliente?action=buscar">Perfil</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </nav>
</header>

<div class="container" style="max-width:700px; margin:40px auto;">

    <h1 style="margin-bottom:30px;">Gerenciar Cartões</h1>

    <%-- Formulário: Novo Cartão --%>
    <div class="form-box" style="margin-bottom:40px;">
        <h2 style="margin-bottom:20px;">Novo Cartão</h2>

        <form action="${pageContext.request.contextPath}/cartao" method="post">
            <input type="hidden" name="action" value="adicionar">

            <label>Nome Impresso no Cartão</label>
            <input type="text" name="nomeImpresso" placeholder="Como aparece no cartão" required>

            <label>Número do Cartão</label>
            <input type="text" name="numeroCartao" placeholder="0000 0000 0000 0000" maxlength="19" required>

            <label>Validade (MM/AA)</label>
            <input type="text" name="validade" placeholder="MM/AA" maxlength="5" required>

            <label>Bandeira</label>
            <select name="bandeiraId" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                <option value="">Selecione</option>
                <c:forEach var="b" items="${bandeiras}">
                    <option value="${b.id}">${b.nome}</option>
                </c:forEach>
            </select>

            <label>CVV</label>
            <input type="text" name="cvv" placeholder="000" maxlength="4" required>

            <button type="submit" class="btn" style="margin-top:10px; width:100%;">Adicionar Cartão</button>
        </form>
    </div>

    <h2 style="margin-bottom:20px;">Cartões Cadastrados</h2>

    <c:choose>
        <c:when test="${empty cartoes}">
            <p style="color:#666;">Nenhum cartão cadastrado ainda.</p>
        </c:when>
        <c:otherwise>
            <table class="table">
                <thead>
                <tr>
                    <th>Nome Impresso</th>
                    <th>Final</th>
                    <th>Bandeira</th>
                    <th>Validade</th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="c" items="${cartoes}">
                    <tr>
                        <td>${c.nomeImpresso}</td>
                        <td>**** ${fn:substring(c.numero, fn:length(c.numero) - 4, fn:length(c.numero))}</td>
                        <td>${c.bandeiraNome}</td>
                        <td>${c.validade}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/cartao" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="excluir">
                                <input type="hidden" name="id" value="${c.id}">
                                <button type="submit" class="btn" style="background:#b00020;"
                                        onclick="return confirm('Excluir este cartão?')">Excluir</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <div style="margin-top:30px; text-align:center;">
        <a href="${pageContext.request.contextPath}/cliente?action=buscar" class="btn">Voltar ao Perfil</a>
    </div>
</div>

<footer>Livraria © 2026</footer>

</body>
</html>
