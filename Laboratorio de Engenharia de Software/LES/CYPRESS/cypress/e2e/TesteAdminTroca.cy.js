// ==========================================
// ARQUIVO: cypress/e2e/TesteAdminTrocas.cy.js
// ==========================================

import login from "../pages/login/TesteIndex"
import dashboard from "../pages/AdminDashboard/TesteIndex"
import trocas from "../pages/AdminTrocas/TesteIndex"

import usuarios from "../fixtures/usuarios.json"

describe('Admin - Devoluções e Trocas', () => {

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

    it('Deve validar acesso da página', () => {

        trocas.validar('acessoPagina')
    })

    it('Deve validar estrutura da página', () => {

        trocas.validar('estrutura')
    })

    it('Deve validar navbar', () => {

        trocas.validar('navbar')
    })

    it('Deve validar sidebar', () => {

        trocas.validar('sidebar')
    })

    it('Deve validar página automaticamente', () => {

        trocas.validar()
    })

    it('Deve aprovar troca', () => {

        trocas.clicarBotao('aprovar', 2)

        trocas.validarMensagem('aprovada')
    })

    it('Deve recusar troca', () => {

        trocas.clicarBotao('recusar', 2)

        trocas.validarMensagem('recusada')
    })

    it('Deve registrar recebimento', () => {

        trocas.clicarBotao('aprovar', 2)

        trocas.clicarBotao('receber', 2)

        trocas.validarMensagem('sucesso')
    })

    it('Deve concluir troca', () => {

        trocas.clicarBotao('aprovar', 2)

        trocas.clicarBotao('receber', 2)

        trocas.clicarBotao('concluir', 2)

        trocas.validarMensagem('concluida')
    })

})