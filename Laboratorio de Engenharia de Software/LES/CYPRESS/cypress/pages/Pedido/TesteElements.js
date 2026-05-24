export const elements = {
    urls: {
        detalhePedido: 'http://localhost:8080/LES/view/pedidoDetalhe.jsp'
    },

    textos: {
        titulo: 'Pedido',
        voltar: '← Voltar aos Pedidos'
    },

    campos: {
        numeroPedido: '[data-test="detalhe-pedido-numero"]',
        totalPedido: '[data-test="detalhe-pedido-total"]'
    },

    status: {
        bar: '[data-test="status-bar-pedido"]',
        confirmado: '[data-test="status-confirmado"]',
        separando: '[data-test="status-separando"]',
        enviado: '[data-test="status-enviado"]',
        entregue: '[data-test="status-entregue"]'
    },

    botoes: {
        voltar: '[data-test="btn-voltar"]',
        sair: '[data-test="btn-sair"]',
        solicitarTroca: 'a.btn',
    },
}