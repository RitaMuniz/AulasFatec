// cypress/e2e/adminGerenciaPedidos.cy.js
// ==========================================
// TESTE: Administrador confirma pagamento e gerencia pedidos
// ==========================================

import login from "../pages/login/TesteIndex"
import dashboard from "../pages/AdminDashboard/TesteIndex"
import adminPedidos from "../pages/AdminPedidos/TesteIndex"
import editarPedido from "../pages/AdminEditarPedido/TesteIndex"
import pedidoDetalheAdmin from "../pages/AdminDetalhesPedido/TesteIndex"

import usuarios from "../fixtures/usuarios.json"

describe('Administrador - Gerenciamento de Pedidos', () => {

    beforeEach(() => {
        cy.resetarBanco()

        login.visitarPagina()
        login.preencherCampo('username', usuarios.admin.email)
        login.preencherCampo('password', usuarios.admin.senha)
        login.clicarBotao('entrar')
        dashboard.validarAcessoPagina()
    })

    afterEach(() => {
        cy.resetarBanco()
    })

    // ==========================================
    // CENÁRIO 12: Admin confirma pagamento do pedido
    // ==========================================
    it('CT12 - Administrador confirma pagamento de pedido pendente', () => {
        // Arrange - Acessar pedidos
        dashboard.clicarBotao('pedidos')


        // Act - Editar pedido e alterar status para CONFIRMADO
        adminPedidos.clicarBotao('editar', 7) // Pedido EM_PROCESSAMENTO
        editarPedido.campo('status', 'CONFIRMADO')
        editarPedido.clicarBotao('salvar')

        // Assert
        editarPedido.validarStatusDetalhe('CONFIRMADO')

        // Voltar e verificar na lista
        adminPedidos.clicarBotao('pedidos')
        cy.get('[data-test="pedido-id-7-status-CONFIRMADO"]').should('exist')
    })

    // ==========================================
    // CENÁRIO 13: Admin define produto como EM TRANSPORTE
    // ==========================================
    it('CT13 - Administrador define produto como EM TRANSPORTE (ENVIADO)', () => {
        // Arrange
        dashboard.clicarBotao('pedidos')
        adminPedidos.clicarBotao('editar', 8) // Pedido CONFIRMADO

        // Act - Alterar para ENVIADO
        editarPedido.campo('status', 'ENVIADO')
        editarPedido.clicarBotao('salvar')

        // Assert
        editarPedido.validarStatusDetalhe('ENVIADO')
    })

    // ==========================================
    // CENÁRIO 14: Admin confirma que produto foi ENTREGUE
    // ==========================================
    it('CT14 - Administrador confirma que produto foi ENTREGUE', () => {
        // Arrange
        dashboard.clicarBotao('pedidos')
        adminPedidos.clicarBotao('editar', 9) // Pedido ENVIADO

        // Act - Alterar para ENTREGUE
        editarPedido.campo('status', 'ENTREGUE')
        editarPedido.clicarBotao('salvar')

        // Assert
        editarPedido.validarStatusDetalhe('ENTREGUE')
    })

    // ==========================================
    // CENÁRIO 15: Admin altera status do pedido em sequência
    // ==========================================
    it('CT15 - Administrador realiza fluxo completo de status do pedido', () => {
        dashboard.clicarBotao('pedidos')

        const statusSequence = ['CONFIRMADO', 'SEPARANDO', 'ENVIADO', 'ENTREGUE']

        statusSequence.forEach((status, index) => {
            adminPedidos.clicarBotao('editar', 9)
            editarPedido.campo('status', status)
            editarPedido.clicarBotao('salvar')
            editarPedido.validarStatusDetalhe(status)
            adminPedidos.clicarBotao('pedidos')
        })

        // Validar status final na lista
        cy.get('[data-test="pedido-id-9-status-ENTREGUE"]').should('exist')
    })
})