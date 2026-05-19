export const elements = {

    urls: {
        pedidos: 'http://localhost:8080/LES/admin/pedidos',
        dashboard: 'http://localhost:8080/LES/admin',
        loja: 'http://localhost:8080/LES/view/index.jsp'
    },

    regex: {
        pedidos: /\/LES\/admin\/pedidos(\?.*)?$/,
        dashboard: /\/LES\/(admin|view\/admin\.jsp)$/
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

    busca: {
        campo: '[data-test="campo-buscar"]',
        pesquisar: '[data-test="button-pesquisar"]',
        limpar: '[data-test="button-limpar"]'
    },

    tabela: {

        linhas: 'table tbody tr',

        pedido: {

            id: (id) =>
                `[data-test="pedido-id-${id}"]`,

            cliente: (id, cliente) =>
                `[data-test="pedido-id-${id}-cliente-${cliente}"]`,

            data: (id, data) =>
                `[data-test="pedido-id-${id}-data-${data}"]`,

            valor: (id, valor) =>
                `[data-test="pedido-id-${id}-valor-${valor}"]`,

            status: (id, status) =>
                `[data-test="pedido-id-${id}-status-${status}"]`
        },

        colunas: {

            ids: '[data-test^="pedido-id-"]:not([data-test*="-cliente-"]):not([data-test*="-data-"]):not([data-test*="-valor-"]):not([data-test*="-status-"])',

            clientes: '[data-test*="-cliente-"]',

            datas: '[data-test*="-data-"]',

            valores: '[data-test*="-valor-"]',

            status: '[data-test*="-status-"]'
        },

        botoes: {

            visualizar: (id) =>
                `[data-test="pedido-id-${id}-button-visualizar"]`,

            editar: (id) =>
                `[data-test="pedido-id-${id}-button-editar"]`,

            visualizarTodos: '[data-test*="-button-visualizar"]',

            editarTodos: '[data-test*="-button-editar"]'
        }
    },

    textos: {
        vazio: '.content p'
    }
}