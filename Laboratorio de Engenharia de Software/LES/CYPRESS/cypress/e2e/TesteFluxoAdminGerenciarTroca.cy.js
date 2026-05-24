// cypress/e2e/adminGerenciaTroca.cy.js
// ==========================================
// TESTE: Administrador gerencia trocas/devoluções
// ==========================================

import login from "../pages/login/TesteIndex"
import dashboard from "../pages/AdminDashboard/TesteIndex"
import adminTrocas from "../pages/AdminTrocas/TesteIndex"
import home from "../pages/home/TesteIndex"
import clienteTrocas from "../pages/Trocas/TesteIndex"

import usuarios from "../fixtures/usuarios.json"

describe('Administrador - Gerenciamento de Trocas/Devoluções', () => {

    beforeEach(() => {
        cy.resetarBanco()

        login.visitarPagina()
        login.preencherCampo('username', usuarios.admin.email)
        login.preencherCampo('password', usuarios.admin.senha)
        login.clicarBotao('entrar')
        dashboard.validarAcessoPagina()
        dashboard.clicarBotao('devolucoes')
    })

    afterEach(() => {
        cy.resetarBanco()
    })

    // ==========================================
    // CENÁRIO 16: Admin aceita solicitação de troca
    // ==========================================
    it('CT16 - Administrador aceita solicitação de troca', () => {
        adminTrocas.validar('acessoPagina')

        // Act - Aprovar troca pendente
        adminTrocas.clicarBotao('aprovar', 2)

        // Assert
        adminTrocas.validarMensagem('aprovada')
        cy.get('[data-test="tabela-item-status-APROVADA"]').should('exist')
    })

    // ==========================================
    // CENÁRIO 17: Admin nega solicitação de troca
    // ==========================================
    it('CT17 - Administrador recusa solicitação de troca', () => {
        adminTrocas.validar('acessoPagina')

        // Act - Recusar troca pendente
        adminTrocas.clicarBotao('recusar', 2)

        // Assert
        adminTrocas.validarMensagem('recusada')
        cy.get('[data-test="tabela-item-status-RECUSADA"]').should('exist')
    })

    // ==========================================
    // CENÁRIO 18: Admin confirma recebimento do produto devolvido
    // ==========================================
    it('CT18 - Administrador confirma recebimento do produto devolvido', () => {
        adminTrocas.validar('acessoPagina')

        // Act - Primeiro aprovar, depois registrar recebimento
        adminTrocas.clicarBotao('aprovar', 2)
        adminTrocas.validarMensagem('aprovada')

        adminTrocas.clicarBotao('receber', 2)

        // Assert
        adminTrocas.validarMensagem('sucesso')
        cy.get('[data-test="tabela-item-status-RECEBIDA"]').should('exist')
    })

    // ==========================================
    // CENÁRIO 19: Sistema gera cupom de troca após conclusão
    // ==========================================
    it('CT19 - Sistema gera cupom de troca automaticamente após conclusão da devolução', () => {
        adminTrocas.validar('acessoPagina')

        // Act - Fluxo completo da troca
        adminTrocas.clicarBotao('aprovar', 2)
        adminTrocas.clicarBotao('receber', 2)
        adminTrocas.clicarBotao('concluir', 2)

        // Assert
        adminTrocas.validarMensagem('concluida')

    })

    // ==========================================
    // CENÁRIO 20: Admin realiza fluxo completo de troca
    // ==========================================
    it('CT20 - Fluxo completo de troca (aprovar -> receber -> concluir)', () => {
        adminTrocas.validar('acessoPagina')

        // Act - Executar todas as etapas
        adminTrocas.clicarBotao('aprovar', 2)
        adminTrocas.validarMensagem('aprovada')

        adminTrocas.clicarBotao('receber', 2)
        adminTrocas.validarMensagem('sucesso')

        adminTrocas.clicarBotao('concluir', 2)
        adminTrocas.validarMensagem('concluida')

        // Assert - Troca movida para histórico
        cy.get('[data-test="sem-historico"]').should('not.exist')
        cy.get('[data-test="tabela-item-status-CONCLUIDA"]').should('exist')
    })

    // ==========================================
    // CENÁRIO 21: Validar que cupom gerado pode ser usado pelo cliente
    // ==========================================
    it('CT21 - Cupom de troca gerado fica disponível para o cliente usar', () => {
        // Arrange - Admin conclui troca
        adminTrocas.clicarBotao('aprovar', 2)
        adminTrocas.clicarBotao('receber', 2)
        adminTrocas.clicarBotao('concluir', 2)

        // Obter ID do cupom gerado
        let cupomId
        cy.get('[data-test^="tabela-item-cupom-"]')
            .invoke('text')
            .then((text) => {
                const match = text.match(/\d+/)
                cupomId = match ? match[0] : null

                // Act - Fazer logout e login como cliente
                cy.get('[data-test="icon-sair"]').click()

                login.visitarPagina()
                login.preencherCampo('username', usuarios.rita.email)
                login.preencherCampo('password', usuarios.rita.senha)
                login.clicarBotao('entrar')

                // Assert - Verificar cupom disponível no checkout
                home.validarAcessoPagina()
                home.clicarMenu('livros')
                cy.get('[data-test="btn-ver-detalhes-1"]').click()
                cy.get('[data-test="adicionar_carrinho"]').click()
                cy.get('[data-test="botao-finalizar"]').click()

                cy.get(`[data-test="cupom-${cupomId}"]`).should('exist')
            })
    })
})