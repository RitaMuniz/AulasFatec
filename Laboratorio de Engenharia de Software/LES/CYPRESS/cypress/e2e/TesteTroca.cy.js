// ==========================================
// ARQUIVO: cypress/e2e/TesteClienteTrocas.cy.js
// ==========================================

import login from "../pages/login/TesteIndex"
import home from "../pages/home/TesteIndex"
import clienteTrocas from "../pages/Trocas/TesteIndex"

import usuarios from "../fixtures/usuarios.json"

describe('Cliente - Painel de Minhas Trocas', () => {

    beforeEach(() => {
        cy.resetarBanco()

        login.visitarPagina()
        login.preencherCampo('username', usuarios.rita.email)
        login.preencherCampo('password', usuarios.rita.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()
    })

    afterEach(() => {
        cy.resetarBanco()
    })

    it('Deve validar o acesso e os elementos fixos da página', () => {
        clienteTrocas.visitarPagina()
        clienteTrocas.validar('automatico')
    })

    it('Deve validar o item de troca pendente (ID #2)', () => {
        const trocaPendente = {
            id: 2,
            pedidoId: 8,
            dataSolicitacao: '2026-05-18',
            status: 'SOLICITADA',
            dataRecebimento: '—',
            cupomGerado: '—'
        }

        clienteTrocas.visitarPagina()
        clienteTrocas.validarItemTabela(trocaPendente)
    })

    it('Deve validar o item de troca finalizado com cupom (ID #1)', () => {
        const trocaConcluida = {
            id: 1,
            pedidoId: 2,
            dataSolicitacao: '2026-05-04',
            status: 'CONCLUIDA',
            dataRecebimento: '2026-05-04',
            cupomGerado: '✅ Cupom #7'
        }

        clienteTrocas.visitarPagina()
        clienteTrocas.validarItemTabela(trocaConcluida)
    })

    it('Deve voltar para a tela de Meus Pedidos com sucesso', () => {
        clienteTrocas.visitarPagina()
        clienteTrocas.clicarBotao('voltarMeusPedidos')
        cy.url().should('include', '/pedidos')
    })
})