// ==========================================
// ARQUIVO: cypress/e2e/TesteFluxoContinuoTroca.cy.js
// ==========================================

import login from "../pages/login/TesteIndex"
import home from "../pages/home/TesteIndex"
import clienteTrocas from "../pages/Trocas/TesteIndex"
import dashboard from "../pages/AdminDashboard/TesteIndex"
import adminTrocas from "../pages/AdminTrocas/TesteIndex"

import usuarios from "../fixtures/usuarios.json"

describe('Fluxo Contínuo - Ciclo de Vida da Troca', () => {

    beforeEach(() => {
        // Inicializa/Reseta o estado do banco de dados
        cy.resetarBanco()
    })

    afterEach(() => {
        // Limpa o banco após o término
        cy.resetarBanco()
    })

    it('Deve acompanhar o ciclo completo: Cliente solicita -> Admin aprova, recebe, conclui -> Cliente valida cupom', () => {

        // ---------------------------------------------------------------------
        // PASSO 1: Cliente faz login e verifica troca recém-solicitada (Pendente)
        // ---------------------------------------------------------------------
        login.visitarPagina()
        login.preencherCampo('username', usuarios.rita.email)
        login.preencherCampo('password', usuarios.rita.senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()
        clienteTrocas.visitarPagina()
        clienteTrocas.validar('automatico')

        const trocaInicial = {
            id: 2,
            pedidoId: 8,
            dataSolicitacao: '2026-05-18',
            status: 'SOLICITADA',
            dataRecebimento: '—',
            cupomGerado: '—'
        }
        clienteTrocas.validarItemTabela(trocaInicial)

        // Cliente faz logout para dar lugar ao administrador
        clienteTrocas.clicarBotao('inicio')
        home.clicarMenu('sair') // Garanta que a função ou seletor de logout exista na home

        // ---------------------------------------------------------------------
        // PASSO 2: Admin entra no sistema e processa a troca até a conclusão
        // ---------------------------------------------------------------------
        login.visitarPagina()
        login.preencherCampo('username', usuarios.admin.email)
        login.preencherCampo('password', usuarios.admin.senha)
        login.clicarBotao('entrar')

        dashboard.validarAcessoPagina()
        dashboard.clicarBotao('devolucoes')
        adminTrocas.validar('automatico')

        // Executa as etapas operacionais da troca de ID #2
        adminTrocas.clicarBotao('aprovar', 2)
        adminTrocas.validarMensagem('aprovada')

        adminTrocas.clicarBotao('receber', 2)
        adminTrocas.validarMensagem('sucesso')

        adminTrocas.clicarBotao('concluir', 2)
        adminTrocas.validarMensagem('concluida')

        // Admin sai do sistema
        // Nota: Substitua pelo comando real de logout do admin se houver seletor mapeado
        cy.get('[data-test="icon-sair"]').click()

        // ---------------------------------------------------------------------
        // PASSO 3: Cliente retorna ao painel para validar o encerramento do fluxo
        // ---------------------------------------------------------------------
        login.visitarPagina()
        login.preencherCampo('username', usuarios.rita.email)
        login.preencherCampo('password', usuarios.rita.senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()
        clienteTrocas.visitarPagina()

        // O estado esperado agora deve refletir as ações do administrador
        const trocaFinalizada = {
            id: 2,
            pedidoId: 8,
            dataSolicitacao: '2026-05-18',
            status: 'CONCLUIDA',
            dataRecebimento: '2026-05-18', // Assumindo que o sistema preencha com a data atual
            cupomGerado: '✅ Cupom #' // Procura parcialmente pela geração do cupom na linha do ID 2
        }
        clienteTrocas.validarItemTabela(trocaFinalizada)
    })
})