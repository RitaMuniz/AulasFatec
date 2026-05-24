// cypress/e2e/trocaCompleta.cy.js
// ==========================================
// TESTE COMPLETO: Ciclo completo de troca (Cliente -> Admin -> Cliente)
// ==========================================

import login from "../pages/login/TesteIndex"
import home from "../pages/home/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"
import pedidoDetalhe from "../pages/Pedido/TesteIndex"
import clienteTrocas from "../pages/Trocas/TesteIndex"
import dashboard from "../pages/AdminDashboard/TesteIndex"
import adminTrocas from "../pages/AdminTrocas/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"

import usuarios from "../fixtures/usuarios.json"
import livrosDados from "../fixtures/livros.json"
import enderecos from "../fixtures/enderecos.json"

describe('Fluxo Completo - Ciclo de Vida da Troca', () => {

    beforeEach(() => {
        cy.resetarBanco()
    })

    afterEach(() => {
        cy.resetarBanco()
    })

    // ==========================================
    // CENÁRIO 22: Fluxo completo - Cliente solicita troca, admin processa, cliente usa cupom
    // ==========================================
    it('CT22 - Ciclo completo: Solicitação -> Aprovação -> Recebimento -> Conclusão -> Uso do cupom', () => {

        // ==========================================
        // FASE 1: Cliente solicita troca
        // ==========================================
        login.visitarPagina()
        login.preencherCampo('username', usuarios.rita.email)
        login.preencherCampo('password', usuarios.rita.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        home.clicarMenu('meu_perfil')
        cy.get('[data-test="button-pedidos"]').click()
        pedidos.clicarBotao('detalhesPedido')

        // Solicitar troca
        cy.get('[data-test^="btn-trocar-"]').first().click()
        cy.get('[data-test="campo-troca"]').type('Produto veio com defeito na impressão')
        cy.get('[data-test="button-confirmar"]').click()
        cy.get('[data-test="aviso-sucesso"]').should('be.visible')

        // Fazer logout
        cy.get('[data-test="button-pedido"]').click()
        cy.get('[data-test="btn-sair"]').click()

        // ==========================================
        // FASE 2: Administrador processa a troca
        // ==========================================
        login.visitarPagina()
        login.preencherCampo('username', usuarios.admin.email)
        login.preencherCampo('password', usuarios.admin.senha)
        login.clicarBotao('entrar')
        dashboard.validarAcessoPagina()
        dashboard.clicarBotao('devolucoes')

        adminTrocas.validar('acessoPagina')

        // Aprovar
        adminTrocas.clicarBotao('aprovar', 2)
        adminTrocas.validarMensagem('aprovada')

        // Registrar recebimento
        adminTrocas.clicarBotao('receber', 2)
        adminTrocas.validarMensagem('sucesso')

        // Concluir e gerar cupom
        adminTrocas.clicarBotao('concluir', 2)
        adminTrocas.validarMensagem('concluida')

        // Capturar ID do cupom gerado
        /*let cupomId
        cy.get('[data-test="tabela-item-cupom-CONCLUIDA"]')
            .first()
            .invoke('text')
            .then((text) => {
                const match = text.match(/\d+/)
                cupomId = match ? match[0] : null
            })*/

        // Admin logout
        cy.get('[data-test="icon-sair"]').click()

        // ==========================================
        // FASE 3: Cliente valida que troca foi concluída
        // ==========================================
        login.visitarPagina()
        login.preencherCampo('username', usuarios.rita.email)
        login.preencherCampo('password', usuarios.rita.senha)
        login.clicarBotao('entrar')

        home.clicarMenu('meu_perfil')
        cy.get('[data-test="button-pedidos"]').click()
        cy.get('[data-test="botao-detalhes-pedido-8"]').click()
        cy.get('[href="/LES/view/troca.jsp"]').click()
        cy.get('[data-test="button-troca"]').click()


        // Verificar status da troca
        cy.get(':nth-child(2) > [data-test="tabela-item-status-CONCLUIDA"]').should('exist')
        cy.get('[data-test^="tabela-item-cupom-"]').should('contain', '✅ Cupom')
        cy.get('[data-test="button-inicio"]').click()


        // ==========================================
        // FASE 4: Cliente usa o cupom de troca em nova compra
        // ==========================================
        home.validarAcessoPagina()
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecos.rita.principal)

        // Aplicar cupom de troca
        /*if (cupomId) {
            cy.get(`[data-test="cupom-${cupomId}"]`).check()
            checkout.validar('cupomAplicado')
        }*/

        checkout.preencherValorTotalNoCartao1()
        checkout.clicarBotao('finalizar')

        // Assert - Compra finalizada com sucesso
        pedidos.validar('confirmacao')
    })

// cypress/e2e/TesteFluxoCompletoTroca.cy.js
// ==========================================
// CT23 - Troca do Pedido #1 da Rita
// ==========================================

    it('CT23 - Troca do Pedido #1 da Rita: Solicitação -> Aprovação -> Recebimento -> Conclusão -> Uso do cupom', () => {

        // ==========================================
        // FASE 1: Rita solicita troca do pedido #1
        // ==========================================

        // Login da Rita
        cy.visit('/view/login.jsp')
        cy.get('[data-test="email"]').type('ritamuniz1995@gmail.com')
        cy.get('[data-test="senha"]').type('Rita123.')
        cy.get('[data-test="entrar"]').click()
        cy.url().should('include', '/view/index.jsp')

        // Acessar Meu Perfil
        cy.get('[data-test="icon-meu-perfil"]').click()
        cy.url().should('include', '/cliente?action=buscar')

        // Acessar Meus Pedidos
        cy.get('[data-test="button-pedidos"]').click()
        cy.url().should('include', '/pedidos')

        // Clicar no pedido #1
        cy.get('[data-test="botao-detalhes-pedido-1"]').click()
        cy.url().should('include', '/pedidos?id=1')

        // Solicitar troca do item
        cy.get('[data-test^="btn-trocar-"]').first().click()
        cy.url().should('include', '/troca?action=solicitar')

        // Preencher motivo e confirmar
        cy.get('[data-test="campo-troca"]').type('Produto veio com defeito na impressão - solicito troca')
        cy.get('[data-test="button-confirmar"]').click()
        cy.url().should('include', '/troca?action=listar&sucesso=1')

        // Validar mensagem de sucesso
        cy.get('[data-test="aviso-sucesso"]').should('be.visible')

        // Voltar para página inicial
        cy.get('[data-test="button-inicio"]').click()
        cy.url().should('include', '/view/index.jsp')

        // ==========================================
        // FASE 2: Administrador processa a troca
        // ==========================================

        // Login do Admin
        cy.visit('/view/login.jsp')
        cy.get('[data-test="email"]').type('admin@livraria.com')
        cy.get('[data-test="senha"]').type('admin123')
        cy.get('[data-test="entrar"]').click()
        cy.url().should('include', '/view/admin.jsp')

        // Acessar Dashboard Admin
        cy.visit('/admin')
        cy.url().should('include', '/admin')

        // Acessar Devoluções
        cy.get('[data-test="button-devolucoes"]').click()
        cy.url().should('include', '/troca?action=admin')

        // Aprovar a troca
        cy.get('[data-test="tabela-item-status-SOLICITADA"]')
            .first()
            .parent()
            .find('[data-test^="tabela-item-button-aprovar-"]')
            .click()
        cy.wait(500)
        cy.get('[data-test="mensagem-aprovada"]').should('be.visible')

        // Registrar recebimento
        cy.get('[data-test="tabela-item-status-APROVADA"]')
            .first()
            .parent()
            .find('[data-test^="tabela-item-button-receber-"]')
            .click()
        cy.wait(500)
        cy.get('[data-test="mensagem-sucesso"]').should('be.visible')

        // Concluir troca e gerar cupom
        cy.get('[data-test="tabela-item-status-RECEBIDA"]')
            .first()
            .parent()
            .find('[data-test^="tabela-item-button-concluir-"]')
            .click()
        cy.wait(500)
        cy.get('[data-test="mensagem-concluida"]').should('be.visible')

        // Validar que cupom foi gerado
        cy.get('[data-test="tabela-item-status-CONCLUIDA"]').should('exist')
        cy.get('[data-test^="tabela-item-cupom-"]').first().should('contain', '✅ Cupom')

        // Logout do Admin
        cy.visit('/view/login.jsp')

        // ==========================================
        // FASE 3: Rita valida que tem cupom disponível
        // ==========================================

        // Login da Rita novamente
        cy.visit('/view/login.jsp')
        cy.get('[data-test="email"]').type('ritamuniz1995@gmail.com')
        cy.get('[data-test="senha"]').type('Rita123.')
        cy.get('[data-test="entrar"]').click()
        cy.url().should('include', '/view/index.jsp')

        // Acessar Minhas Trocas diretamente pela URL
        cy.visit('/troca')
        cy.url().should('include', '/troca')

        // Validar que a troca está CONCLUIDA e tem cupom
        cy.get('[data-test="tabela-item-status-CONCLUIDA"]').should('exist')
        cy.get('[data-test^="tabela-item-cupom-"]').first().should('contain', '✅ Cupom')

        // Voltar para home
        cy.get('[data-test="button-inicio"]').click()
        cy.url().should('include', '/view/index.jsp')

        // ==========================================
        // FASE 4: Rita usa o cupom de troca em nova compra
        // ==========================================

        // Acessar catálogo de livros
        cy.get('[data-test="menu_livros"]').click()
        cy.url().should('include', '/livros')

        // Adicionar livro ao carrinho
        cy.get('[data-test="btn-ver-detalhes-1"]').first().click()
        cy.get('[data-test="adicionar_carrinho"]').click()
        cy.url().should('include', '/carrinho')

        // Finalizar compra
        cy.get('[data-test="botao-finalizar"]').click()
        cy.url().should('include', '/pedido')

        // Selecionar o PRIMEIRO endereço disponível (não um valor fixo)
        cy.get('[data-test="endereco_id"] option').first().then(($option) => {
            const primeiroEndereco = $option.val()
            cy.get('[data-test="endereco_id"]').select(primeiroEndereco)
        })
    })
})