import { elements as el } from "./TesteElements"

class DetalhePedidoAdmin {

    validar(tipo = 'automatico', valorEsperado = null){

        const validacoes = {

            estrutura: () => this.validarEstrutura(),

            acessoPagina: () => this.validarAcessoPagina(),

            pedido: () => this.validarPedido(),

            cliente: () => this.validarCliente(),

            itens: () => this.validarItens(),

            financeiro: () => this.validarFinanceiro(),

            valorMonetario: () => this.validarValorMonetario(),

            linksSidebar: () => this.validarLinksSidebar(),

            automatico: () => this.validarAutomatico()
        }

        if(!validacoes[tipo]){
            throw new Error(`Validação "${tipo}" não existe`)
        }

        validacoes[tipo](valorEsperado)
    }

    clicarBotao(botao){

        const botoes = {

            editar: () => {
                cy.get(el.botoes.editar).click()
            },

            voltar: () => {
                cy.get(el.botoes.voltar).first().click()
            },

            default: () => {

                if(!el.sidebar[botao]){
                    throw new Error(`Botão "${botao}" não encontrado`)
                }

                cy.get(el.sidebar[botao]).click()
            }
        }

        if(botoes[botao]){
            botoes[botao]()
            return
        }

        botoes.default()
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
            .and('contain.text', 'Detalhe do Pedido')

        cy.get(el.topbar.voltar)
            .should('exist')
            .and('be.visible')

        cy.get(el.topbar.sair)
            .should('exist')
            .and('be.visible')
    }

    validarAcessoPagina(){

        cy.url()
            .should('match', el.regex.detalhePedido)
    }

    validarPedido(){

        cy.get(el.pedido.data)
            .should('exist')

        cy.get(el.pedido.total)
            .should('exist')
    }

    validarCliente(){

        cy.get(el.cliente.nome)
            .should('exist')

        cy.get(el.cliente.email)
            .should('exist')

        cy.get(el.cliente.cpf)
            .should('exist')
    }

    validarItens(){

        cy.get(el.itens.titulo)
            .should('have.length.at.least', 1)

        cy.get(el.itens.autor)
            .should('exist')

        cy.get(el.itens.quantidade)
            .should('exist')

        cy.get(el.itens.precoUnitario)
            .should('exist')

        cy.get(el.itens.subtotal)
            .should('exist')
    }

    validarFinanceiro(){

        cy.get(el.pedido.total)
            .invoke('text')
            .then(texto => {

                const valor = this.converter(texto)

                expect(valor).to.be.greaterThan(0)
            })
    }

    validarValorMonetario(){

        cy.get(el.itens.precoUnitario)
            .first()
            .invoke('text')
            .should('match', /R\$\s?\d{1,3}(\.\d{3})*,\d{2}/)

        cy.get(el.itens.subtotal)
            .first()
            .invoke('text')
            .should('match', /R\$\s?\d{1,3}(\.\d{3})*,\d{2}/)
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

        cy.get(el.sidebar.devolucoes)
            .should('exist')
    }

    validarAutomatico(){

        this.validarEstrutura()

        this.validarAcessoPagina()

        this.validarPedido()

        this.validarCliente()

        this.validarItens()

        this.validarFinanceiro()

        this.validarLinksSidebar()
    }
}

export default new DetalhePedidoAdmin()