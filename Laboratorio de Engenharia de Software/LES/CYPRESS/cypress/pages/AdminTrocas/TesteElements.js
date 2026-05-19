// ==========================================
// ARQUIVO: cypress/pages/AdminTrocas/TesteElements.js
// ==========================================

export const elements = {

    regex: {
        pagina: /\/LES\/troca\?action=admin/
    },

    titulo: 'h1',

    navbar: {
        loja: '[data-test="icon-loja"]',
        sair: '[data-test="icon-sair"]'
    },

    sidebar: {
        dashboard: '[data-test="button-dashboard"]',
        pedidos: '[data-test="button-pedidos"]',
        livros: '[data-test="button-livros"]',
        clientes: '[data-test="button-clientes"]',
        devolucoes: '[data-test="button-devolucoes"]',
        relatorio: '[data-test="button-relatorio"]'
    },

    mensagens: {
        concluida: '[data-test="mensagem-concluida"]',
        aprovada: '[data-test="mensagem-aprovada"]',
        recusada: '[data-test="mensagem-recusada"]',
        sucesso: '[data-test="mensagem-sucesso"]',
        erro: '[data-test="mensagem-erro"]',
        nenhumaSolicitacao: '[data-test="mensagem-nenhuma-solicitacao"]',
        semHistorico: '[data-test="sem-historico"]'
    }
}