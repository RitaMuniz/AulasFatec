<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin – Devoluções / Trocas</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
    <style>
        table { width: 100%; border-collapse: collapse; }
        th { background: #4a3728; color: #fff; padding: 10px; text-align: left; font-size: 13px; }
        td { padding: 10px; border-bottom: 1px solid #eee; font-size: 13px; vertical-align: middle; }
        tr:nth-child(even) { background: #fafafa; }

        .badge { padding: 3px 9px; border-radius: 10px; font-size: 11px; font-weight: bold; white-space: nowrap; }
        .SOLICITADA { background: #fff3cd; color: #856404; }
        .APROVADA   { background: #cff4fc; color: #055160; }
        .RECEBIDA   { background: #d1e7dd; color: #0f5132; }
        .CONCLUIDA  { background: #d1e7dd; color: #0f5132; }
        .RECUSADA   { background: #f8d7da; color: #842029; }

        .acoes form { display: inline; }
        .acoes button, .acoes a {
            padding: 5px 10px;
            margin: 2px;
            font-size: 12px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-visualizar { background: #6c757d; color: #fff; }
        .btn-aprovar    { background: #0dcaf0; color: #000; }
        .btn-receber    { background: #198754; color: #fff; }
        .btn-concluir   { background: #0d6efd; color: #fff; }
        .btn-recusar    { background: #dc3545; color: #fff; }

        .aviso-sucesso {
            background: #d1e7dd; border: 1px solid #badbcc; border-radius: 6px;
            padding: 10px; margin-bottom: 15px; color: #0f5132;
        }
        .aviso-erro {
            background: #f8d7da; border: 1px solid #f5c2c7; border-radius: 6px;
            padding: 10px; margin-bottom: 15px; color: #842029;
        }

        h2.section { margin-top: 30px; border-bottom: 2px solid #4a3728; padding-bottom: 6px; }
    </style>
</head>
<body>

<header class="topbar">
    <h1>Devoluções / Trocas</h1>
    <div>
        <a data-test="icon-loja" href="${pageContext.request.contextPath}/view/index.jsp">Ver Loja</a>
        <a data-test="icon-sair" href="${pageContext.request.contextPath}/logout">Sair</a>
    </div>
</header>

<div class="layout">

    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a data-test="button-dashboard" href="${pageContext.request.contextPath}/admin">Dashboard</a>
            <a data-test="button-pedidos" href="${pageContext.request.contextPath}/admin/pedidos">Pedidos</a>
            <a data-test="button-livros" href="${pageContext.request.contextPath}/view/admin-livros.html">Livros</a>
            <a data-test="button-clientes" href="${pageContext.request.contextPath}/view/admin-clientes.jsp">Clientes</a>
            <a data-test="button-devolucoes" href="${pageContext.request.contextPath}/troca?action=admin" class="active">Devoluções</a>
            <a data-test="button-relatorio" href="${pageContext.request.contextPath}/view/admin-relatorios.html">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <%-- Mensagens de feedback --%>
        <c:if test="${param.sucesso == 'concluida'}">
            <div data-test="mensagem-concluida" class="aviso-sucesso">✅ Troca concluída e cupom de troca gerado com sucesso!</div>
        </c:if>
        <c:if test="${param.sucesso == 'aprovada'}">
            <div data-test="mensagem-aprovada" class="aviso-sucesso">✅ Troca aprovada com sucesso!</div>
        </c:if>
        <c:if test="${param.sucesso == 'recusada'}">
            <div data-test="mensagem-recusada" class="aviso-sucesso">ℹ️ Troca recusada.</div>
        </c:if>
        <c:if test="${param.sucesso == 'recebida'}">
            <div data-test="mensagem-sucesso" class="aviso-sucesso">✅ Recebimento do item registrado!</div>
        </c:if>
        <c:if test="${not empty param.erro}">
            <div data-test="mensagem-erro" class="aviso-erro">⚠️ Erro: ${param.erro}</div>
        </c:if>

        <%-- ===== SEÇÃO: Pendentes ===== --%>
        <h2 class="section">Solicitações Pendentes</h2>

        <c:set var="temPendentes" value="false" />
        <c:forEach var="t" items="${trocas}">
            <c:if test="${t.status == 'SOLICITADA' || t.status == 'APROVADA' || t.status == 'RECEBIDA'}">
                <c:set var="temPendentes" value="true" />
            </c:if>
        </c:forEach>

        <c:choose>
            <c:when test="${!temPendentes}">
                <p data-test="mensagem-nenhuma-solicitacao">Nenhuma solicitação pendente.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Pedido</th>
                            <th>Solicitação</th>
                            <th>Motivo</th>
                            <th>Status</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${trocas}">
                            <c:if test="${t.status == 'SOLICITADA' || t.status == 'APROVADA' || t.status == 'RECEBIDA'}">
                                <tr>
                                    <td data-test="tabela-item-id-${t.id}">${t.id}</td>
                                    <td data-test="tabela-item-pedido-${t.pedidoId}">#${t.pedidoId}</td>
                                    <td data-test="tabela-item-dataSolicitacao-${t.dataSolicitacao}">${t.dataSolicitacao}</td>
                                    <td style="max-width:200px; word-break:break-word;" data-test="tabela-item-motivo-${t.motivo}">${t.motivo}</td>
                                    <td data-test="tabela-item-status-${t.status}"><span class="badge ${t.status}">${t.status}</span></td>
                                    <td data-test="tabela-item-acoes" class="acoes">

                                        <%-- Ver pedido vinculado --%>
                                        <a href="${pageContext.request.contextPath}/admin/pedidos?id=${t.pedidoId}"
                                           class="btn-visualizar" data-test="tabela-item-button-visualizar-${t.pedidoId}" >Ver Pedido</a>

                                        <%-- Aprovar ou Recusar (SOLICITADA) --%>
                                        <c:if test="${t.status == 'SOLICITADA'}">
                                            <form action="${pageContext.request.contextPath}/troca" method="post">
                                                <input data-test="tabela-item-aprovar-${t.pedidoId}" type="hidden" name="action"  value="aprovar">
                                                <input data-test="tabela-item-aprovar-${t.id}" type="hidden" name="trocaId" value="${t.id}">
                                                <button data-test="tabela-item-button-aprovar-${t.id}" class="btn-aprovar" type="submit"
                                                        onclick="return confirm('Aprovar esta solicitação de troca?')">
                                                    Aprovar
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/troca" method="post">
                                                <input data-test="tabela-item-recusar-${t.pedidoId}" type="hidden" name="action"  value="recusar">
                                                <input data-test="tabela-item-recusar-${t.id}" type="hidden" name="trocaId" value="${t.id}">
                                                <button data-test="tabela-item-button-recusar-${t.id}" class="btn-recusar" type="submit"
                                                        onclick="return confirm('Recusar esta troca?')">
                                                    Recusar
                                                </button>
                                            </form>
                                        </c:if>

                                        <%-- Marcar como recebido (APROVADA) --%>
                                        <c:if test="${t.status == 'APROVADA'}">
                                            <form action="${pageContext.request.contextPath}/troca" method="post">
                                                <input data-test="tabela-item-receber-${t.pedidoId}" type="hidden" name="action"  value="receber">
                                                <input data-test="tabela-item-receber-${t.id}" type="hidden" name="trocaId" value="${t.id}">
                                                <button data-test="tabela-item-button-receber-${t.id}" class="btn-receber" type="submit">Marcar Recebido</button>
                                            </form>
                                        </c:if>

                                        <%-- Concluir + gerar cupom (RECEBIDA) --%>
                                        <c:if test="${t.status == 'RECEBIDA'}">
                                            <form action="${pageContext.request.contextPath}/troca" method="post">
                                                <input data-test="tabela-item-concluir-${t.pedidoId}" type="hidden" name="action"  value="concluir">
                                                <input data-test="tabela-item-concluir-${t.id}" type="hidden" name="trocaId" value="${t.id}">
                                                <button data-test="tabela-item-button-concluir-${t.id}" class="btn-concluir" type="submit"
                                                        onclick="return confirm('Concluir troca e gerar cupom para o cliente?')">
                                                    Concluir + Cupom
                                                </button>
                                            </form>
                                        </c:if>

                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

        <%-- ===== SEÇÃO: Histórico ===== --%>
        <h2 class="section">Histórico de Devoluções</h2>

        <c:set var="temHistorico" value="false" />
        <c:forEach var="t" items="${trocas}">
            <c:if test="${t.status == 'CONCLUIDA' || t.status == 'RECUSADA'}">
                <c:set var="temHistorico" value="true" />
            </c:if>
        </c:forEach>

        <c:choose>
            <c:when test="${!temHistorico}">
                <p data-test="sem-historico" >Nenhum registro no histórico.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Pedido</th>
                            <th>Solicitação</th>
                            <th>Motivo</th>
                            <th>Status</th>
                            <th>Cupom</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${trocas}">
                            <c:if test="${t.status == 'CONCLUIDA' || t.status == 'RECUSADA'}">
                                <tr>
                                    <td data-test="tabela-item-id-${t.id}">${t.id}</td>
                                    <td data-test="tabela-item-pedidoid-${t.pedidoId}">
                                        <a href="${pageContext.request.contextPath}/admin/pedidos?id=${t.pedidoId}">
                                            #${t.pedidoId}
                                        </a>
                                    </td>
                                    <td data-test="tabela-item-dataSolicitacao-${t.dataSolicitacao}">${t.dataSolicitacao}</td>
                                    <td style="max-width:200px; word-break:break-word;" data-test="tabela-item-motivo-${t.motivo}" >${t.motivo}</td>
                                    <td data-test="tabela-item-status-${t.status}" ><span class="badge ${t.status}">${t.status}</span></td>
                                    <td data-test="tabela-item-cupom-${t.cupomGeradoId}">
                                        <c:choose>
                                            <c:when test="${t.status == 'CONCLUIDA'}">
                                                <span style="color:#198754;">✅ Cupom #${t.cupomGeradoId}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color:#dc3545;">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

    </main>
</div>

<footer>
    Área Administrativa – Livraria © 2026
</footer>

</body>
</html>
