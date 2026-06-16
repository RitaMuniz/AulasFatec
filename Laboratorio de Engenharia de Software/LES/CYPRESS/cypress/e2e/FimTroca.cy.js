// ==========================================
// ARQUIVO: cypress/e2e/TesteClienteTrocas.cy.js
// ==========================================

import login from "../pages/login/TesteIndex"
import home from "../pages/home/TesteIndex"
import clienteTrocas from "../pages/Trocas/TesteIndex"

import usuarios from "../fixtures/usuariosTeste.json"
import clientejson from "../fixtures/cliente.json";

describe('Cliente - Painel de Minhas Trocas', () => {

    beforeEach(() => {
        cy.resetarBanco()

        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
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

    it('Deve validar o item de troca pendente (ID #11)', () => {
        const trocaPendente = {
            /*id: 2,
            pedidoId: 8,
            dataSolicitacao: '2026-05-18',
            status: 'SOLICITADA',
            dataRecebimento: '—',
            cupomGerado: '—'*/

            id: 11,
            pedidoId: 1,
            status: "SOLICITADA",
            dataSolicitacao: "2026-06-11",
            dataRecebimento: '—',
            item_pedido_id: '—',
            motivo: "Livro rasgado",
            cupomGerado: '—'
        }

        clienteTrocas.visitarPagina()
        clienteTrocas.validarItemTabela(trocaPendente)
    })

    it('Deve validar o item de troca recusada (ID #12)', () => {
        const trocaPendente = {
            /*id: 2,
            pedidoId: 8,
            dataSolicitacao: '2026-05-18',
            status: 'SOLICITADA',
            dataRecebimento: '—',
            cupomGerado: '—'*/

            id: 12,
            pedidoId: 31,
            status: "RECUSADA",
            dataSolicitacao: "2026-06-11",
            dataRecebimento: '—',
            item_pedido_id: '—',
            motivo: "Livro Molhado",
            cupomGerado: '—'
        }

        clienteTrocas.visitarPagina()
        clienteTrocas.validarItemTabela(trocaPendente)
    })

    it('Deve validar o item de troca aprovada (ID #13)', () => {
        const trocaPendente = {
            /*id: 2,
            pedidoId: 8,
            dataSolicitacao: '2026-05-18',
            status: 'SOLICITADA',
            dataRecebimento: '—',
            cupomGerado: '—'*/

            id: 13,
            pedidoId: 61,
            status: "APROVADA",
            dataSolicitacao: "2026-06-11",
            dataRecebimento: '—',
            item_pedido_id: 129,
            motivo: "Livro em Branco",
            cupomGerado: '—'
        }

        clienteTrocas.visitarPagina()
        clienteTrocas.validarItemTabela(trocaPendente)
    })

    it('Deve validar o item de troca recebida (ID #14)', () => {
        const trocaPendente = {
            /*id: 2,
            pedidoId: 8,
            dataSolicitacao: '2026-05-18',
            status: 'SOLICITADA',
            dataRecebimento: '—',
            cupomGerado: '—'*/

            id: 14,
            pedidoId: 121,
            status: "RECEBIDA",
            dataSolicitacao: "2026-06-11",
            dataRecebimento: '—',
            item_pedido_id: 248,
            motivo: "Livro Torto",
            cupomGerado: '—'
        }

        clienteTrocas.visitarPagina()
        clienteTrocas.validarItemTabela(trocaPendente)
    })


    it('Deve validar o item de troca finalizado com cupom (ID #15)', () => {
        const trocaConcluida = {
            id: 15,
            pedidoId: 91,
            dataSolicitacao: '2026-06-11',
            status: 'CONCLUIDA',
            dataRecebimento: '2026-06-11',
            cupomGerado: '✅ Cupom #21'
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