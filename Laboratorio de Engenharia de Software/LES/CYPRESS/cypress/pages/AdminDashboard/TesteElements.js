export const elements = {

    urls: {
        dashboard: 'http://localhost:8080/LES/admin',
        pedidos: 'http://localhost:8080/LES/admin/pedidos',
        loja: 'http://localhost:8080/LES/view/index.jsp'
    },

    topbar: {
        titulo: '.topbar h1'
    },

    sidebar: {
        dashboard: '[data-test="button-dashboard"]',
        pedidos: '[data-test="button-pedidos"]',
        livros: '[data-test="button-livros"]',
        clientes: '[data-test="button-clientes"]',
        devolucoes: '[data-test="button-devolucoes"]',
        relatorios: '[data-test="button-relatorios"]',
        loja: '[data-test="button-loja"]',
        sair: '[data-test="button-sair"]'
    },

    cards: {
        totalPedidos: '.dashboard .card:nth-child(1) p',
        emProcessamento: '.dashboard .card:nth-child(2) p',
        faturamentoTotal: '.dashboard .card:nth-child(3) p'
    },

    tabela: {
        linhas: 'table tbody tr',
        pedido: 'table tbody tr td:nth-child(1)',
        cliente: 'table tbody tr td:nth-child(2)',
        data: 'table tbody tr td:nth-child(3)',
        valor: 'table tbody tr td:nth-child(4)',
        status: 'table tbody tr td:nth-child(5)',
        acao: '.btn-link'
    },

    textos: {
        tituloUltimosPedidos: 'h2'
    }
}