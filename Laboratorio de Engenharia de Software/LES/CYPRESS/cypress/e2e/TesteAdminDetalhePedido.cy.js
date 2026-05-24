import login from "../pages/login/TesteIndex"
import dashboard from "../pages/AdminDashboard/TesteIndex"
import pedidos from "../pages/AdminPedidos/TesteIndex"
import detalhePedidoAdmin from "../pages/AdminDetalhesPedido/TesteIndex"

import usuarios from "../fixtures/usuarios.json"
import PedidosAdmin from "../pages/AdminPedidos/TesteIndex";

describe('Admin - Detalhe Pedido', () => {

    beforeEach(() => {

        login.visitarPagina()

        login.preencherCampo('username', usuarios.admin.email)

        login.preencherCampo('password', usuarios.admin.senha)

        login.clicarBotao('entrar')

        dashboard.clicarBotao('pedidos')

        pedidos.clicarBotao('visualizar', 7)



    })

    it('Deve validar estrutura da página', () => {

        detalhePedidoAdmin.validar('estrutura')
    })

    it('Deve validar acesso da página', () => {

        detalhePedidoAdmin.validar('acessoPagina')
    })

    it('Deve validar informações do pedido', () => {

        detalhePedidoAdmin.validar('pedido')
    })

    it('Deve validar informações do cliente', () => {

        detalhePedidoAdmin.validar('cliente')
    })

    it('Deve validar itens do pedido', () => {

        detalhePedidoAdmin.validar('itens')
    })

    it('Deve validar resumo financeiro', () => {

        detalhePedidoAdmin.validar('financeiro')
    })

    it('Deve validar valores monetários', () => {

        detalhePedidoAdmin.validar('valorMonetario')
    })

    it('Deve validar sidebar', () => {

        detalhePedidoAdmin.validar('linksSidebar')
    })

    it('Deve voltar para pedidos', () => {

        detalhePedidoAdmin.clicarBotao('voltar')

        cy.url()
            .should('match', /\/LES\/admin\/pedidos/)
    })

    it('Deve acessar edição do pedido', () => {

        detalhePedidoAdmin.clicarBotao('editar')

        cy.url()
            .should('include', 'acao=editar')
    })

    it('Deve validar página automaticamente', () => {

        detalhePedidoAdmin.validar()
    })
})