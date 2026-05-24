export const elements = {

    urls: {
        detalhePedido: 'http://localhost:8080/LES/admin/pedidos?id=',
        pedidos: 'http://localhost:8080/LES/admin/pedidos',
        dashboard: 'http://localhost:8080/LES/admin'
    },

    regex: {
        detalhePedido: /\/LES\/admin\/pedidos\?id=\d+/,
        pedidos: /\/LES\/admin\/pedidos(\?.*)?$/,
        dashboard: /\/LES\/(admin|view\/admin\.jsp)$/
    },

    topbar: {
        titulo: '.topbar h1',
        voltar: '[data-test="button-voltar"]',
        sair: '[data-test="button-sair"]'
    },

    sidebar: {
        dashboard: '[data-test="button-dashboard"]',
        pedidos: '[data-test="button-pedidos"]',
        livros: '[data-test="button-livros"]',
        clientes: '[data-test="button-clientes"]',
        devolucoes: '[data-test="button-devolucoes"]',
        relatorio: '[data-test="button-relatorio"]'
    },

    pedido: {

        numero: (id) =>
            `[data-test="pedido-numero-${id}"]`,

        data: '[data-test^="pedido-data-"]',

        status: '[data-test^="pedido-numero-EM_"],',

        total: '[data-test^="pedido-total-"]'
    },

    cliente: {

        nome: '[data-test^="cliente-nome-"]',

        email: '[data-test^="cliente-email-"]',

        cpf: '[data-test^="cliente-cpf-"]'
    },

    itens: {

        titulo: '[data-test^="cliente-titulo-"]',

        autor: '[data-test^="cliente-autor-"]',

        quantidade: '[data-test^="cliente-quantidade-"]',

        precoUnitario: '[data-test^="cliente-precoUnitario-"]',

        subtotal: '[data-test^="cliente-subtotal-"]'
    },

    botoes: {
        editar: '[data-test="button-editar"]',
        voltar: '[data-test="button-voltar"]'
    }
}