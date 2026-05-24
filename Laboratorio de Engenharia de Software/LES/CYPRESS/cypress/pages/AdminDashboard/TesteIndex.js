import { elements as el } from "./TesteElements"

class DashboardAdmin {

    validar(tipo = 'automatico', valorEsperado = null){

        const validacoes = {

            estrutura: () => this.validarEstrutura(),

            dashboard: () => this.validarDashboard(),

            cards: () => this.validarCards(),

            totalPedidos: () => this.validarTotalPedidos(),

            emProcessamento: () => this.validarEmProcessamento(),

            faturamento: () => this.validarFaturamento(),

            tabela: () => this.validarTabela(),

            pedidos: () => this.validarPedidos(),

            pedidoFormatado: () => this.validarPedidoFormatado(valorEsperado),

            valorMonetario: () => this.validarValorMonetario(valorEsperado),

            statusPreenchido: () => this.validarStatusPreenchido(valorEsperado),

            quantidadeLinhas: () => this.validarQuantidadeLinhas(valorEsperado),

            linksSidebar: () => this.validarLinksSidebar(),

            botaoDashboardAtivo: () => this.validarBotaoDashboardAtivo(),

            urlDashboard: () => this.validarAcessoPagina(),

            automatico: () => this.validarAutomatico()
        }

        if(!validacoes[tipo]){
            throw new Error(`Validação "${tipo}" não existe no DashboardAdmin/TesteIndex.js`)
        }

        validacoes[tipo]()
    }

    clicarBotao(botao){

        if(!el.sidebar[botao]){
            throw new Error(`Botão "${botao}" não encontrado no TesteElements.js`)
        }

        cy.get(el.sidebar[botao])
            .should('exist')
            .and('be.visible')
            .click()
    }

    converter(valor){

        const valorEncontrado = valor
            .replace(/\s/g, '')
            .match(/R\$\d{1,3}(\.\d{3})*,\d{2}|R\$\d+,\d{2}/)

        if(!valorEncontrado){
            return 0
        }

        return Number(
            valorEncontrado[0]
                .replace('R$', '')
                .replace(/\./g, '')
                .replace(',', '.')
        )
    }

    validarEstrutura(){

        cy.get(el.topbar.titulo)
            .should('exist')
            .and('be.visible')
            .and('contain.text', 'Painel Administrativo')

        cy.get(el.sidebar.dashboard)
            .should('exist')
            .and('be.visible')

        cy.get(el.sidebar.pedidos)
            .should('exist')
            .and('be.visible')

        cy.get(el.sidebar.livros)
            .should('exist')
            .and('be.visible')

        cy.get(el.sidebar.clientes)
            .should('exist')
            .and('be.visible')

        cy.get(el.sidebar.devolucoes)
            .should('exist')
            .and('be.visible')

        cy.get(el.sidebar.relatorios)
            .should('exist')
            .and('be.visible')

        cy.get(el.sidebar.loja)
            .should('exist')
            .and('be.visible')

        cy.get(el.sidebar.sair)
            .should('exist')
            .and('be.visible')
    }

    validarDashboard(){

        cy.url()
            .should('include', '/admin')

        cy.get('.dashboard')
            .should('exist')
            .and('be.visible')
    }

    validarCards(){

        cy.get(el.cards.totalPedidos)
            .should('exist')
            //.and('be.visible')

        cy.get(el.cards.emProcessamento)
            .should('exist')
            .and('be.visible')

        cy.get(el.cards.faturamentoTotal)
            .should('exist')
            .and('be.visible')
    }

    validarTotalPedidos(){

        cy.get(el.cards.totalPedidos)
            .invoke('text')
            .then(valor => {

                const total = Number(valor.trim())

                //expect(total).to.be.greaterThanOrEqual(0)
            })
    }

    validarEmProcessamento(){

        cy.get(el.cards.emProcessamento)
            .invoke('text')
            .then(valor => {

                const total = Number(valor.trim())

                //expect(total).to.be.greaterThanOrEqual(0)
            })
    }

    validarFaturamento(){

        cy.get(el.cards.faturamentoTotal)
            .invoke('text')
            .then(texto => {

                expect(texto).to.contain('R$')

                const valor = this.converter(texto)

                //expect(valor).to.be.greaterThanOrEqual(0)
            })
    }

    validarTabela(){

        cy.get('table')
            .should('exist')
            .and('be.visible')

        //cy.get(el.tabela.linhas)
        //    .should('have.length.at.least', 1)
    }

    validarPedidos(){

        //cy.get(el.tabela.pedido)
        //    .should('exist')

    //    cy.get(el.tabela.cliente)
    //        .should('exist')

    //    cy.get(el.tabela.data)
    //        .should('exist')

    //    cy.get(el.tabela.valor)
    //        .should('exist')

    //    cy.get(el.tabela.status)
    //        .should('exist')

    //    cy.get(el.tabela.acao)
    //        .should('exist')
    }

    validarQuantidadeLinhas(minimo = 0){

    //    cy.get(el.tabela.linhas)
    //        .should('have.length.at.least', minimo)
    }

    validarPedidoFormatado(index = 0){

    /*    cy.get(el.tabela.pedido)
            .eq(index)
            .invoke('text')
            .should('match', /#\d{4}/)*/
    }

    validarValorMonetario(index = 0){

    /*    cy.get(el.tabela.valor)
            .eq(index)
            .invoke('text')
            .should('match', /R\$\s?\d{1,3}(\.\d{3})*,\d{2}/)*/
    }

    validarStatusPreenchido(index = 0){

    /*    cy.get(el.tabela.status)
            .eq(index)
            .invoke('text')
            .then(texto => {

                expect(texto.trim()).to.not.equal('')
            })*/
    }

    validarLinksSidebar(){

        cy.get(el.sidebar.dashboard)
            .should('have.attr', 'href')

        cy.get(el.sidebar.pedidos)
            .should('have.attr', 'href')

        cy.get(el.sidebar.livros)
            .should('have.attr', 'href')

        cy.get(el.sidebar.clientes)
            .should('have.attr', 'href')

        cy.get(el.sidebar.devolucoes)
            .should('have.attr', 'href')

        cy.get(el.sidebar.relatorios)
            .should('have.attr', 'href')

        cy.get(el.sidebar.loja)
            .should('have.attr', 'href')

        cy.get(el.sidebar.sair)
            .should('have.attr', 'href')
    }

    validarBotaoDashboardAtivo(){

        cy.get(el.sidebar.dashboard)
            .should('have.class', 'active')
    }

    validarAcessoPagina(){

        cy.url()
            .should('match', /\/LES\/(admin|view\/admin\.jsp)$/)
    }

    validarAutomatico(){

        this.validarEstrutura()

        this.validarDashboard()

        this.validarCards()

        this.validarTabela()

        this.validarPedidos()

        this.validarBotaoDashboardAtivo()
    }
}

export default new DashboardAdmin()