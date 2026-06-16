// cypress/e2e/adminGerenciaTroca.cy.js
// ==========================================
// TESTE: Administrador gerencia trocas/devoluções
// ==========================================

import login from "../pages/login/TesteIndex"
import dashboard from "../pages/AdminDashboard/TesteIndex"
import adminTrocas from "../pages/AdminTrocas/TesteIndex"
import home from "../pages/home/TesteIndex"
import clienteTrocas from "../pages/Trocas/TesteIndex"

import usuarios from "../fixtures/usuariosTeste.json"
import clientejson from "../fixtures/cliente.json";
import trocajson from "../fixtures/troca.json";
import livros from "../pages/Livros/TesteIndex";
import livrojson from "../fixtures/livro.json";
import livro from "../pages/Livro/TesteIndex";
import carrinho from "../pages/Carrinho/TesteIndex";

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
        adminTrocas.clicarBotao('aprovar', trocajson["troca_id_11"].id)

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
        adminTrocas.clicarBotao('recusar', trocajson["troca_id_11"].id)

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
        adminTrocas.clicarBotao('aprovar', trocajson["troca_id_11"].id)
        adminTrocas.validarMensagem('aprovada')

        adminTrocas.clicarBotao('receber', trocajson["troca_id_11"].id)

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
        adminTrocas.clicarBotao('aprovar', trocajson["troca_id_11"].id)
        adminTrocas.clicarBotao('receber', trocajson["troca_id_11"].id)
        adminTrocas.clicarBotao('concluir', trocajson["troca_id_11"].id)

        // Assert
        adminTrocas.validarMensagem('concluida')

    })

    // ==========================================
    // CENÁRIO 20: Admin realiza fluxo completo de troca
    // ==========================================
    it('CT20 - Fluxo completo de troca (aprovar -> receber -> concluir)', () => {
        adminTrocas.validar('acessoPagina')

        // Act - Executar todas as etapas
        adminTrocas.clicarBotao('aprovar', trocajson["troca_id_11"].id)
        adminTrocas.validarMensagem('aprovada')

        adminTrocas.clicarBotao('receber', trocajson["troca_id_11"].id)
        adminTrocas.validarMensagem('sucesso')

        adminTrocas.clicarBotao('concluir', trocajson["troca_id_11"].id)
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
        adminTrocas.clicarBotao('aprovar', trocajson["troca_id_11"].id)
        adminTrocas.clicarBotao('receber', trocajson["troca_id_11"].id)
        adminTrocas.clicarBotao('concluir', trocajson["troca_id_11"].id)

        // Obter ID do cupom gerado
        let cupomId
        cy.get('[data-test^="tabela-item-cupom-25"]')
            .invoke('text')
            .then((text) => {
                const match = text.match(/\d+/)
                cupomId = match ? match[0] : null

                // Act - Fazer logout e login como cliente
                cy.get('[data-test="icon-sair"]').click()

                login.visitarPagina()
                login.preencherCampo('username', clientejson["Odete Roitman"].email)
                login.preencherCampo('password', clientejson["Odete Roitman"].senha)
                login.clicarBotao('entrar')

                // Assert - Verificar cupom disponível no checkout
                home.validarAcessoPagina()
                home.clicarMenu('livros')

                livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
                livro.clicarBotao('adicionarCarrinho')
                carrinho.clicarBotao('finalizar')

                cy.get(`[data-test="cupom-${cupomId}"]`).should('exist')
            })
    })
})