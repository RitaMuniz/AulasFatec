<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin – Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
</head>
<body>

<header class="topbar">
    <h1>Painel Administrativo</h1>
    <div>
        <a href="${pageContext.request.contextPath}/home" data-test="button-loja">Ver Loja</a>
        <a href="${pageContext.request.contextPath}/logout" data-test="button-sair">Sair</a>
    </div>
</header>

<div class="layout">
    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/admin" class="active" data-test="button-dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/pedidos" data-test="button-pedidos">Pedidos</a>
            <a href="${pageContext.request.contextPath}/admin-livros" data-test="button-livros">Livros</a>
            <a href="${pageContext.request.contextPath}/view/admin-clientes.jsp" data-test="button-clientes">Clientes</a>
            <a href="${pageContext.request.contextPath}/troca?action=admin" data-test="button-devolucoes">Devoluções</a>
            <a href="${pageContext.request.contextPath}/admin-relatorios" data-test="button-relatorios">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <div class="dashboard">
            <div class="grafico-container">
                <h3>Vendas Mensais por Categoria</h3>

                <form>
                    <div class="form-grid">
                        <div>
                            <label for="dataInicio">Data Inicial</label>
                            <input type="date" id="dataInicio">
                        </div>
                        <div>
                            <label for="dataFim">Data Final</label>
                            <input type="date" id="dataFim">
                        </div>
                        <div class="form-actions">
                            <button type="button" onclick="carregarGrafico()">Filtrar</button>
                            <button type="button" onclick="limparFiltro()" class="btn-cancelar">Limpar</button>
                        </div>
                    </div>
                </form>

                <div id="grafico-status" style="display:none; text-align:center; padding:1rem; color:#666;"></div>
                <div style="position:relative; height:600px; width:1000px;">
                <canvas id="graficoVendas"></canvas>
                </div>
            </div>
        </div>

        <h2>Últimos Pedidos</h2>

        <table>
            <thead>
            <tr>
                <th>Pedido</th>
                <th>Cliente</th>
                <th>Data</th>
                <th>Valor Total</th>
                <th>Status</th>
                <th>Ação</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="p" items="${pedidos}" end="9">
                <tr>
                    <td>#<fmt:formatNumber value="${p.id}" minIntegerDigits="4"/></td>
                    <td>${not empty p.cliente ? p.cliente.nome : '—'}</td>
                    <td><fmt:formatDate value="${p.dataCriacao}" pattern="dd/MM/yyyy"/></td>
                    <td>R$ <fmt:formatNumber value="${p.total}" minFractionDigits="2" maxFractionDigits="2"/></td>
                    <td>${p.status}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/pedidos?id=${p.id}" class="btn-link">Ver Pedido</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Contexto disponível para o JS
    const CTX_PATH = '${pageContext.request.contextPath}';

    let chart = null;

    // Paleta de cores para as categorias
    const CORES = [
        '#4e79a7','#f28e2b','#e15759','#76b7b2',
        '#59a14f','#edc948','#b07aa1','#ff9da7',
        '#9c755f','#bab0ac'
    ];

    async function carregarGrafico() {
        const inicio = document.getElementById('dataInicio').value;
        const fim    = document.getElementById('dataFim').value;
        const status = document.getElementById('grafico-status');

        // Monta a URL; os parâmetros são opcionais no backend
        let url = CTX_PATH + '/relatorio-vendas';
        const params = new URLSearchParams();
        if (inicio) params.append('inicio', inicio);
        if (fim)    params.append('fim', fim);
        if (params.toString()) url += '?' + params.toString();

        status.style.display = 'block';
        status.textContent = 'Carregando...';

        try {
            const response = await fetch(url);
            if (!response.ok) throw new Error('Erro HTTP ' + response.status);
            const dados = await response.json();

            if (!dados || dados.length === 0) {
                status.textContent = 'Nenhum dado encontrado para o período selecionado.';
                if (chart) { chart.destroy(); chart = null; }
                return;
            }

            status.style.display = 'none';
            renderizarGrafico(dados);

        } catch (e) {
            status.textContent = 'Erro ao carregar dados: ' + e.message;
            console.error(e);
        }
    }

    function renderizarGrafico(dados) {
        // Extrai meses e categorias únicos (mantendo ordem)
        const meses      = [...new Set(dados.map(d => d.mes))].sort();
        const categorias = [...new Set(dados.map(d => d.categoria))].sort();

        const datasets = categorias.map((cat, i) => ({
            label: cat,
            data: meses.map(m => {
                const item = dados.find(d => d.mes === m && d.categoria === cat);
                return item ? item.total : 0;
            }),
            borderColor: CORES[i % CORES.length],
            backgroundColor: CORES[i % CORES.length] + '33', // 20% opacidade
            tension: 0.3,
            fill: false,
            pointRadius: 4
        }));

        if (chart) chart.destroy();

        chart = new Chart(document.getElementById('graficoVendas'), {
            type: 'line',
            data: { labels: meses, datasets: datasets },
            options: {
                responsive: true,
                maintainAspectRatio: false, // container pai tem altura fixa (380px)
                plugins: {
                    legend: { position: 'bottom' },
                    tooltip: {
                        callbacks: {
                            // Exibe "Qtd: X" no tooltip
                            label: ctx => ` ${ctx.dataset.label}: ${ctx.parsed.y} un.`
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        title: { display: true, text: 'Quantidade Vendida' },
                        ticks: { stepSize: 1 }
                    },
                    x: {
                        title: { display: true, text: 'Mês' }
                    }
                }
            }
        });
    }

    function limparFiltro() {
        document.getElementById('dataInicio').value = '';
        document.getElementById('dataFim').value = '';
        if (chart) { chart.destroy(); chart = null; }
        document.getElementById('grafico-status').style.display = 'none';
        carregarGrafico(); // recarrega sem filtro
    }

    // Carrega o gráfico automaticamente ao abrir a página (sem filtro de data)
    window.addEventListener('DOMContentLoaded', carregarGrafico);
</script>

<footer>Área Administrativa – Livraria © 2026</footer>
</body>
</html>
