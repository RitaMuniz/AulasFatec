import dashboard from "../pages/AdminDashboard/TesteIndex"
import login from "../pages/login/TesteIndex";
import usuarios from "../fixtures/usuarios.json";

describe('Dashboard Administrativo', () => {

    beforeEach(() => {

        login.visitarPagina()
        login.preencherCampo('username', usuarios.admin.email)
        login.preencherCampo('password', usuarios.admin.senha)
        login.clicarBotao('entrar')
    })

    it('Deve validar estrutura principal do dashboard', () => {

        dashboard.validar('estrutura')

        dashboard.validar('dashboard')

        dashboard.validar('cards')

        dashboard.validar('tabela')
    })

    it('Deve validar cards do dashboard', () => {

        dashboard.validar('totalPedidos')

        dashboard.validar('emProcessamento')

        dashboard.validar('faturamento')
    })

    it('Deve validar tabela de pedidos', () => {

        dashboard.validar('pedidos')

        dashboard.validar('quantidadeLinhas', 1)

        dashboard.validar('pedidoFormatado', 0)

        dashboard.validar('valorMonetario', 0)

        dashboard.validar('statusPreenchido', 0)
    })

    it('Deve validar links da sidebar', () => {

        dashboard.validar('linksSidebar')
    })

    it('Deve validar botão dashboard ativo', () => {

        dashboard.validar('botaoDashboardAtivo')
    })

    it('Deve validar URL do dashboard', () => {

        dashboard.validar('urlDashboard')
    })

    it('Deve acessar página de pedidos', () => {

        dashboard.clicarBotao('pedidos')

        cy.url()
            .should('include', '/admin/pedidos')
    })

    it('Deve acessar página da loja', () => {

        dashboard.clicarBotao('loja')

        cy.url()
            .should('include', '/view/index.jsp')
    })

    it('Deve validar dashboard automaticamente', () => {

        dashboard.validar()
    })
})