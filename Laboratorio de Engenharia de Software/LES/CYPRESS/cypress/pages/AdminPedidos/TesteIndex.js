import { elements as el } from "./TesteElements"

class PedidosAdmin {

    validar(tipo = 'automatico', valorEsperado = null){

        const validacoes = {

            estrutura: () => this.validarEstrutura(),

            tabela: () => this.validarTabela(),

            pedidos: () => this.validarPedidos(),

            busca: () => this.validarBusca(),

            linksSidebar: () => this.validarLinksSidebar(),

            pedidoFormatado: () => this.validarPedidoFormatado((valorEsperado-1)*3),

            valorMonetario: () => this.validarValorMonetario((valorEsperado-1)),

            statusPreenchido: () => this.validarStatusPreenchido((valorEsperado-1)),

            quantidadeLinhas: () => this.validarQuantidadeLinhas(valorEsperado),

            urlPedidos: () => this.validarAcessoPagina(),

            automatico: () => this.validarAutomatico()
        }

        if(!validacoes[tipo]){
            throw new Error(`Validação "${tipo}" não existe no PedidosAdmin/TesteIndex.js`)
        }

        validacoes[tipo]()
    }

    clicarBotao(botao, id = null){

        const botoes = {

            pesquisar: () => {
                cy.get(el.busca.pesquisar).click()
            },

            limpar: () => {
                cy.get(el.busca.limpar).click()
            },

            visualizar: () => {

                if(id){
                    cy.get(el.tabela.botoes.visualizar(id))
                        .click()

                    return
                }

                cy.get(el.tabela.botoes.visualizarTodos)
                    .first()
                    .click()
            },

            editar: () => {

                if(id){
                    cy.get(el.tabela.botoes.editar(id))
                        .click()

                    return
                }

                cy.get(el.tabela.botoes.editarTodos)
                    .first()
                    .click()
            },

            default: () => {

                if(!el.sidebar[botao]){
                    throw new Error(`Botão "${botao}" não encontrado`)
                }

                cy.get(el.sidebar[botao])
                    .click()
            }
        }

        if(botoes[botao]){
            botoes[botao]()
            return
        }

        botoes.default()
    }

    preencherCampo(valor){

        cy.get(el.busca.campo)
            .clear()
            .type(valor)
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
            .should('contain.text', 'Gerenciar Pedidos')

        cy.get(el.busca.campo)
            .should('exist')
            .and('be.visible')

        cy.get(el.busca.pesquisar)
            .should('exist')
            .and('be.visible')

        cy.get(el.busca.limpar)
            .should('exist')
            .and('be.visible')
    }

    validarStatusPedido(id, status){

        cy.get(`[data-test="pedido-id-${id}-status"]`)
            .should('contain.text', status)
    }

    validarStatusPedidos(id, status){

        cy.get(el.tabela.pedido.status(id, status))
            .should('exist')
            .and('contain.text', status)
    }
    validarBusca(){

        cy.get(el.busca.campo)
            .should('have.attr', 'placeholder')

        cy.get(el.busca.campo)
            .should('not.be.disabled')
    }

    validarTabela(){

        cy.get('table')
            .should('exist')
            .and('be.visible')
    }

    validarPedidos(){

        cy.get(el.tabela.colunas.ids)
            .should('exist')

        cy.get(el.tabela.colunas.clientes)
            .should('exist')

        cy.get(el.tabela.colunas.datas)
            .should('exist')

        cy.get(el.tabela.colunas.valores)
            .should('exist')

        cy.get(el.tabela.colunas.status)
            .should('exist')
    }

    validarQuantidadeLinhas(minimo = 0){

        cy.get(el.tabela.linhas)
            .should('have.length.at.least', minimo)
    }

    validarPedidoFormatado(index = 0){

        cy.get(el.tabela.colunas.ids)
            .eq(index)
            .invoke('text')
            .should('match', /^#\d\s\d{3}$/)
    }

    validarValorMonetario(index = 0){

        cy.get(el.tabela.colunas.valores)
            .eq(index)
            .invoke('text')
            .should('match', /R\$\s?\d{1,3}(\.\d{3})*,\d{2}/)
    }

    validarStatusPreenchido(index = 0){

        cy.get(el.tabela.colunas.status)
            .eq(index)
            .invoke('text')
            .then(texto => {

                expect(texto.trim()).to.not.equal('')
            })
    }

    validarLinksSidebar(){

        cy.get(el.sidebar.dashboard)
            .should('exist')

        cy.get(el.sidebar.pedidos)
            .should('have.class', 'active')

        cy.get(el.sidebar.livros)
            .should('exist')

        cy.get(el.sidebar.clientes)
            .should('exist')
    }

    validarAcessoPagina(){

        cy.url()
            .should('match', el.regex.pedidos)
    }

    validarAutomatico(){

        this.validarEstrutura()

        this.validarBusca()

        this.validarTabela()

        this.validarPedidos()

        this.validarLinksSidebar()

        this.validarAcessoPagina()
    }
}

export default new PedidosAdmin()