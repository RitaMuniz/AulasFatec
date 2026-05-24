// ==========================================
// ARQUIVO: cypress/pages/ClienteTrocas/TesteElements.js
// ==========================================

export const elements = {
    regex: {
        pagina: /\/troca/ // URL correspondente ao href do menu do cliente
    },

    titulo: 'h2',

    navbar: {
        inicio: '[data-test="button-inicio"]',
        meusPedidos: '[data-test="button-pedido"]',
        minhasTrocas: '[data-test="button-troca"]'
    },

    mensagens: {
        sucesso: '[data-test="aviso-sucesso"]',
        nenhumaSolicitacao: '[data-test="aviso-solicitacao"]'
    },

    botoes: {
        voltarMeusPedidos: '[data-test="button-meus-pedidos"]',
        inicio: '[data-test="button-inicio"]'
    }
}