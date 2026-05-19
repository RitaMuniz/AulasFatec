import PedidosAdmin from "../pages/AdminPedidos/TesteIndex"
import login from "../pages/login/TesteIndex"
import usuarios from "../fixtures/usuarios.json"
import dashboard from "../pages/AdminDashboard/TesteIndex"
import { elements as el } from "../pages/AdminPedidos/TesteElements"

describe('Admin - Pedidos', () => {

    beforeEach(() => {

        login.visitarPagina()

        login.preencherCampo('username', usuarios.admin.email)

        login.preencherCampo('password', usuarios.admin.senha)

        login.clicarBotao('entrar')

        dashboard.clicarBotao('pedidos')
    })

    it('Deve validar estrutura da página', () => {

        PedidosAdmin.validar('estrutura')
    })

    it('Deve validar campo de busca', () => {

        PedidosAdmin.validar('busca')
    })

    it('Deve validar tabela de pedidos', () => {

        PedidosAdmin.validar('tabela')

        PedidosAdmin.validar('pedidos')
    })

    it('Deve validar quantidade de linhas da tabela', () => {

        PedidosAdmin.validar('quantidadeLinhas', 7)
    })

    it('Deve validar formatação do pedido', () => {

        PedidosAdmin.validar('pedidoFormatado', 1)
    })

    it('Deve validar valor monetário', () => {

        PedidosAdmin.validar('valorMonetario', 1)
    })

    it('Deve validar status preenchido', () => {

        PedidosAdmin.validar('statusPreenchido', 1)
    })

    it('Deve validar links da sidebar', () => {

        PedidosAdmin.validar('linksSidebar')
    })

    it('Deve validar URL da página de pedidos', () => {

        PedidosAdmin.validar('urlPedidos')
    })

    it('Deve pesquisar pedido por número', () => {

        PedidosAdmin.preencherCampo('1')

        PedidosAdmin.clicarBotao('pesquisar')

        cy.get(el.busca.campo)
            .should('have.value', '1')
    })

    it('Deve pesquisar pedido por cliente', () => {

        PedidosAdmin.preencherCampo('Maria')

        PedidosAdmin.clicarBotao('pesquisar')

        cy.get(el.busca.campo)
            .should('have.value', 'Maria')
    })

    it('Deve limpar pesquisa', () => {

        PedidosAdmin.preencherCampo('Teste')

        PedidosAdmin.clicarBotao('limpar')

        cy.url()
            .should('match', el.regex.pedidos)
    })

    it('Deve acessar dashboard', () => {

        PedidosAdmin.clicarBotao('dashboard')

        cy.url()
            .should('match', el.regex.dashboard)
    })

    it('Deve acessar loja', () => {

        PedidosAdmin.clicarBotao('loja')

        cy.url()
            .should('include', '/view/index.jsp')
    })

    it('Deve acessar visualização do pedido', () => {

        PedidosAdmin.clicarBotao('visualizar')

        cy.url()
            .should('include', '/admin/pedidos?id=')
    })

    it('Deve acessar edição do pedido', () => {

        PedidosAdmin.clicarBotao('editar')

        cy.url()
            .should('include', 'acao=editar')
    })

    it('Deve validar página automaticamente', () => {

        PedidosAdmin.validar()
    })
})