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
        <a href="${pageContext.request.contextPath}/home">Home</a>
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
            <select data-test="endereco-tipo" id="tipoEndereco" name="tipoEndereco" required
                    style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                <option data-test="endereco-tipo-ENTREGA" value="ENTREGA">Entrega</option>
                <option data-test="endereco-tipo-COBRANCA" value="COBRANCA">Cobrança</option>
            </select>

            <label>Tipo de Residência</label>
            <input data-test="endereco-tipo-residencia" type="text" id="tipoResidencia" name="tipoResidencia" placeholder="Casa, Apartamento..." required>

            <label>Tipo de Logradouro</label>
            <input data-test="endereco-tipo-logradouro" type="text" id="tipoLogradouro" name="tipoLogradouro" placeholder="Rua, Avenida..." required>

            <label>Logradouro</label>
            <input data-test="endereco-lograduro" type="text" id="logradouro" name="logradouro" placeholder="Nome da rua" required>

            <label>Número</label>
            <input data-test="endereco-numero" type="text" id="numeroEndereco" name="numeroEndereco" placeholder="123" required>

            <label>Bairro</label>
            <input data-test="endereco-bairro" type="text" id="bairro" name="bairro" placeholder="Seu bairro" required>

            <label>CEP</label>
            <input data-test="endereco-cep" type="text" id="cep" name="cep" placeholder="00000-000" maxlength="9" required>

            <label for="cidade">Cidade *</label>
            <input data-test="endereco-cidade" type="text" id="cidade" name="cidadeNome" placeholder="Sua Cidade" required>

            <label>Estado</label>
            <select data-test="endereco-estado" name="estadoId" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                <option value="">Selecione</option>
                <c:forEach var="e" items="${estados}">
                    <option data-test="endereco-tipo-${e.nome}" value="${e.id}">${e.nome}</option>
                </c:forEach>
            </select>

            <label>Observações (opcional)</label>
            <input data-test="endereco-observacoes" type="text" id="observacoes" name="observacoes" placeholder="Complemento, referência...">

            <div style="display:flex; gap:10px; margin-top:10px;">
                <button data-test="button-salvar" type="submit" class="btn" style="flex:1;">Salvar Endereço</button>
                <button data-test="button-cancelar" type="button" class="btn" style="background:#888; flex:0 0 auto;"
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
                        <td data-test="tabela-tipo-endereco-${e.tipoEndereco}" >${e.tipoEndereco}</td>
                        <td data-test="tabela-tipo-logradouro-${e.tipoLogradouro}">${e.tipoLogradouro} ${e.logradouro}</td>
                        <td data-test="tabela-numero-${e.numero}">${e.numero}</td>
                        <td data-test="tabela-bairro-${e.bairro}">${e.bairro}</td>
                        <td data-test="tabela-cep-${e.cep}">${e.cep}</td>
                        <td style="white-space:nowrap;">
                            <%-- Botão Editar: popula o form via JS --%>
                            <button data-test="button-editar" class="btn" onclick="editarEndereco(
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
                                <button data-test="button-excluir" type="submit" class="btn" style="background:#b00020;"
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
<%@ include file="chatbot-widget.jsp" %>
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
