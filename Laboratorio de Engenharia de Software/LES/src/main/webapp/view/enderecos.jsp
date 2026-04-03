<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Meus Endereços</title>
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

    <h1 style="margin-bottom:30px;">Gerenciar Endereços</h1>

    <div class="form-box" style="margin-bottom:40px;">
        <h2 id="formTitulo" style="margin-bottom:20px;">Novo Endereço</h2>

        <form id="formEndereco" action="${pageContext.request.contextPath}/endereco" method="post">
            <%-- action começa como "adicionar"; JS troca para "editar" se necessário --%>
            <input type="hidden" id="formAction" name="action" value="adicionar">
            <input type="hidden" id="formId" name="id" value="">

            <label>Tipo de Endereço</label>
            <select id="tipoEndereco" name="tipoEndereco" required
                    style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                <option value="ENTREGA">Entrega</option>
                <option value="COBRANCA">Cobrança</option>
            </select>

            <label>Tipo de Residência</label>
            <input type="text" id="tipoResidencia" name="tipoResidencia" placeholder="Casa, Apartamento..." required>

            <label>Tipo de Logradouro</label>
            <input type="text" id="tipoLogradouro" name="tipoLogradouro" placeholder="Rua, Avenida..." required>

            <label>Logradouro</label>
            <input type="text" id="logradouro" name="logradouro" placeholder="Nome da rua" required>

            <label>Número</label>
            <input type="text" id="numeroEndereco" name="numeroEndereco" placeholder="123" required>

            <label>Bairro</label>
            <input type="text" id="bairro" name="bairro" placeholder="Seu bairro" required>

            <label>CEP</label>
            <input type="text" id="cep" name="cep" placeholder="00000-000" maxlength="9" required>

            <label for="cidade">Cidade *</label>
            <input type="text" id="cidade" name="cidadeNome" placeholder="Sua Cidade" required>

            <label>Estado</label>
            <select name="estadoId" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                <option value="">Selecione</option>
                <c:forEach var="e" items="${estados}">
                    <option value="${e.id}">${e.nome}</option>
                </c:forEach>
            </select>

            <label>Observações (opcional)</label>
            <input type="text" id="observacoes" name="observacoes" placeholder="Complemento, referência...">

            <div style="display:flex; gap:10px; margin-top:10px;">
                <button type="submit" class="btn" style="flex:1;">Salvar Endereço</button>
                <button type="button" class="btn" style="background:#888; flex:0 0 auto;"
                        onclick="resetarForm()">Cancelar</button>
            </div>
        </form>
    </div>

    <%-- Tabela de endereços cadastrados --%>
    <h2 style="margin-bottom:20px;">Endereços Cadastrados</h2>

    <c:choose>
        <c:when test="${empty enderecos}">
            <p style="color:#666;">Nenhum endereço cadastrado ainda.</p>
        </c:when>
        <c:otherwise>
            <table class="table">
                <thead>
                <tr>
                    <th>Tipo</th>
                    <th>Logradouro</th>
                    <th>Nº</th>
                    <th>Bairro</th>
                    <th>CEP</th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="e" items="${enderecos}">
                    <tr>
                        <td>${e.tipoEndereco}</td>
                        <td>${e.tipoLogradouro} ${e.logradouro}</td>
                        <td>${e.numero}</td>
                        <td>${e.bairro}</td>
                        <td>${e.cep}</td>
                        <td style="white-space:nowrap;">
                            <%-- Botão Editar: popula o form via JS --%>
                            <button class="btn" onclick="editarEndereco(
                                '${e.id}',
                                '${e.tipoEndereco}',
                                '${e.tipoResidencia}',
                                '${e.tipoLogradouro}',
                                '${e.logradouro}',
                                '${e.numero}',
                                '${e.bairro}',
                                '${e.cep}',
                                '${e.observacoes}'
                            )">Editar</button>

                            <%-- Botão Excluir --%>
                            <form action="${pageContext.request.contextPath}/endereco" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="excluir">
                                <input type="hidden" name="id" value="${e.id}">
                                <button type="submit" class="btn" style="background:#b00020;"
                                        onclick="return confirm('Excluir este endereço?')">Excluir</button>
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

<script>
    function editarEndereco(id, tipoEndereco, tipoResidencia, tipoLogradouro,
                            logradouro, numero, bairro, cep, observacoes) {
        document.getElementById('formAction').value = 'editar';
        document.getElementById('formId').value = id;
        document.getElementById('formTitulo').textContent = 'Editar Endereço';

        document.getElementById('tipoEndereco').value = tipoEndereco;
        document.getElementById('tipoResidencia').value = tipoResidencia;
        document.getElementById('tipoLogradouro').value = tipoLogradouro;
        document.getElementById('logradouro').value = logradouro;
        document.getElementById('numeroEndereco').value = numero;
        document.getElementById('bairro').value = bairro;
        document.getElementById('cep').value = cep;
        document.getElementById('observacoes').value = observacoes;

        document.getElementById('formEndereco').scrollIntoView({ behavior: 'smooth' });
    }

    function resetarForm() {
        document.getElementById('formAction').value = 'adicionar';
        document.getElementById('formId').value = '';
        document.getElementById('formTitulo').textContent = 'Novo Endereço';
        document.getElementById('formEndereco').reset();
    }
</script>

</body>
</html>
