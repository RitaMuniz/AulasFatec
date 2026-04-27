import { elements as el } from "./TesteElements";

class Carrinho {

    constructor(){
        this.campos = {}
    }

    validarAcessoPagina(){
        cy.url().should('match', el.urls.carrinhoRegex)
    }

    montarSeletorComId(seletorBase, id){
        return `${seletorBase}${id}${el.sufixoDataTest}`
    }

    montarCampoQuantidade(id){
        return this.montarSeletorComId(el.campos.quantidade, id)
    }

    montarBotaoComId(botao, id){
        return this.montarSeletorComId(el.botoes[botao], id)
    }

    alterarCampo(campo, id, valor){
        const campos = {
            quantidade: () => {
                this.campos[campo] = {
                    id: id,
                    valor: valor
                }

                cy.get(this.montarCampoQuantidade(id))
                    .clear()
                    .type(valor)
            }
        }

        campos[campo]()
    }

    clicarBotao(botao, id = null){
        if(id !== null){
            cy.get(this.montarBotaoComId(botao, id)).click()
            return
        }

        cy.get(el.botoes[botao]).click()
    }

    validar(tipo = 'automatico', id = null, valor = null){
        const validacoes = {
            acessoPagina: () => this.validarAcessoPagina(),

            estrutura: () => this.validarEstrutura(),

            quantidade: () => this.validarQuantidade(id, valor),

            quantidadeInvalida: () => this.validarQuantidadeInvalida(id),

            resumo: () => this.validarResumo(),

            totalEstimado: () => this.validarTotalEstimado(),

            automatico: () => this.validarAutomatico()
        }

        validacoes[tipo]()
    }

    validarEstrutura(){
        cy.get(el.textos.subtotal).should('exist').and('be.visible')
        cy.get(el.textos.valorFrete).should('exist').and('be.visible')
        cy.get(el.textos.totalEstimado).should('exist').and('be.visible')
    }

    validarQuantidade(id, valor){
        cy.get(this.montarCampoQuantidade(id))
            .should('have.value', String(valor))
    }

    validarQuantidadeInvalida(id){
        cy.get(this.montarCampoQuantidade(id))
            .then(el.validarMensagemNavegador)
    }

    validarResumo(){
        cy.get(el.textos.subtotal).should('contain.text', 'R$')
        cy.get(el.textos.valorFrete).should('contain.text', el.textosEsperados.fretePadrao)
        cy.get(el.textos.totalEstimado).should('contain.text', 'R$')
    }

    validarTotalEstimado(){
        cy.get(el.textos.subtotal).invoke('text').then(subtotalTexto => {
            cy.get(el.textos.valorFrete).invoke('text').then(freteTexto => {
                cy.get(el.textos.totalEstimado).invoke('text').then(totalTexto => {

                    const subtotal = this.converterMoedaParaNumero(subtotalTexto)
                    const frete = this.converterMoedaParaNumero(freteTexto)
                    const total = this.converterMoedaParaNumero(totalTexto)

                    expect(total).to.be.closeTo(subtotal + frete, 0.01)
                })
            })
        })
    }

    converterMoedaParaNumero(texto){
        const valor = texto
            .replace(/\s/g, '')
            .match(/R\$\d{1,3}(\.\d{3})*,\d{2}|R\$\d+,\d{2}/)

        if(!valor){
            return 0
        }

        return Number(
            valor[0]
                .replace('R$', '')
                .replace(/\./g, '')
                .replace(',', '.')
        )
    }

    validarAutomatico(){
        cy.then(() => {
            this.validar('acessoPagina')

            if(this.campos.quantidade){
                const id = this.campos.quantidade.id
                const valor = this.campos.quantidade.valor

                if(valor <= 0){
                    this.validar('quantidadeInvalida', id)
                    return
                }

                this.validar('quantidade', id, valor)
            }

            this.validar('resumo')
            this.validar('totalEstimado')
        })
    }
}

export default new Carrinho();