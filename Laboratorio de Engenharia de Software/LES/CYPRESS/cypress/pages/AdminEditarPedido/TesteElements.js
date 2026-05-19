// ==========================================
// ARQUIVO: cypress/pages/AdminEditarPedido/TesteElements.js
// ==========================================

export const elements = {

    regex: {
        editarPedido: /\/LES\/admin\/pedidos\?id=\d+&acao=editar/
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
        relatorio: '[data-test="button-relatorio"]'
    },

    cliente: {

        nome: '[data-test^="pedido-cliente-nome-"]',

        email: '[data-test^="pedido-cliente-email-"]',

        cpf: '[data-test^="pedido-cliente-cpf-"]'
    },

    form: {

        status: '[data-test="pedido-status"]'
    },

    itens: {

        titulo: '[data-test^="pedido-item-titulo-"]',

        quantidade: '[data-test^="pedido-item-quantidade-"]',

        precoUnitario: '[data-test^="pedido-item-precoUnitario-"]',

        subtotal: '[data-test^="pedido-item-subtotal-"]'
    },

    total: '[data-test^="pedido-total-"]',

    botoes: {

        salvar: '[data-test="button-salvar"]',

        cancelar: '[data-test="button-cancelar"]'
    }
}