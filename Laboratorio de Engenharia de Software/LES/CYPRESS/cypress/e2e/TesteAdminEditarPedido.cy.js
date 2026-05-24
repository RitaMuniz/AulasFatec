// ==========================================
// ARQUIVO: cypress/e2e/editarPedido.cy.js
// ==========================================

import login from "../pages/login/TesteIndex"
import dashboard from "../pages/AdminDashboard/TesteIndex"
import pedidos from "../pages/AdminPedidos/TesteIndex"
import editarPedido from "../pages/AdminEditarPedido/TesteIndex"

import usuarios from "../fixtures/usuarios.json"

describe('Admin - Editar Pedido', () => {

    beforeEach(() => {

        login.visitarPagina()

        login.preencherCampo('username', usuarios.admin.email)

        login.preencherCampo('password', usuarios.admin.senha)

        login.clicarBotao('entrar')

        dashboard.clicarBotao('pedidos')

        pedidos.clicarBotao('editar', 7)
    })

    // =========================================
    // VALIDAÇÕES
    // =========================================

    it('Deve validar estrutura da página', () => {

        editarPedido.validar('estrutura')
    })

    it('Deve validar acesso da página', () => {

        editarPedido.validar('acessoPagina')
    })

    it('Deve validar dados do cliente', () => {

        editarPedido.validar('cliente')
    })

    it('Deve validar status do pedido', () => {

        editarPedido.validar('status')
    })

    it('Deve validar itens do pedido', () => {

        editarPedido.validar('itens')
    })

    it('Deve validar valor total do pedido', () => {

        editarPedido.validar('total')
    })

    it('Deve validar sidebar', () => {

        editarPedido.validar('sidebar')
    })

    it('Deve validar página automaticamente', () => {

        editarPedido.validar()
    })

    // =========================================
    // EDIÇÕES
    // =========================================

    it('Deve alterar status para CONFIRMADO', () => {

        editarPedido.campo('status', 'CONFIRMADO')

        editarPedido.validarCampo('status', 'CONFIRMADO')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('CONFIRMADO')
    })

    it('Deve alterar status para SEPARANDO', () => {

        editarPedido.campo('status', 'SEPARANDO')

        editarPedido.validarCampo('status', 'SEPARANDO')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('SEPARANDO')
    })

    it('Deve alterar status para ENVIADO', () => {

        editarPedido.campo('status', 'ENVIADO')

        editarPedido.validarCampo('status', 'ENVIADO')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('ENVIADO')
    })

    it('Deve alterar status para ENTREGUE', () => {

        editarPedido.campo('status', 'ENTREGUE')

        editarPedido.validarCampo('status', 'ENTREGUE')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('ENTREGUE')
    })

    it('Deve alterar status para CANCELADO', () => {

        editarPedido.campo('status', 'CANCELADO')

        editarPedido.validarCampo('status', 'CANCELADO')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('CANCELADO')
    })

    // =========================================
    // BOTÕES
    // =========================================

    it('Deve cancelar edição do pedido', () => {

        editarPedido.clicarBotao('cancelar')

        cy.url()
            .should('match', /\/LES\/admin\/pedidos\?id=\d+/)
    })

    // =========================================
    // SIDEBAR
    // =========================================

    it('Deve acessar dashboard pela sidebar', () => {

        editarPedido.clicarBotao('dashboard')

        cy.url()
            .should('match', /\/LES\/admin/)
    })

    it('Deve acessar pedidos pela sidebar', () => {

        editarPedido.clicarBotao('pedidos')

        cy.url()
            .should('match', /\/LES\/admin\/pedidos/)
    })
})