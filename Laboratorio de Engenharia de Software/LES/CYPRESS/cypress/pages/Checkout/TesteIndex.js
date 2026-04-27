import { elements as el } from "./TesteElements";

class Checkout {

    constructor(){
        this.campos = {}
    }

    montarSeletorComId(seletorBase, id){
        return `${seletorBase}${id}${el.sufixoDataTest}`
    }

    validar(tipo = 'automatico', valorEsperado = null){
        const validacoes = {
            estrutura: () => this.validarEstrutura(),
            endereco: () => this.validarEndereco(),
            enderecoSelecionado: () => this.validarEnderecoSelecionado(valorEsperado),

            cartao1: () => this.validarCartao1(),
            cartaoSelecionado: () => this.validarCartaoSelecionado(valorEsperado),
            cartao2: () => this.validarCartao2(),

            resumo: () => this.validarResumo(),
            total: () => this.validarTotal(),
            valorCartao: () => this.validarValorCartao(),
            freteCalculado: () => this.validarFrete(),
            botoesAuxiliares: () => this.validarBotoes(),

            cartaoObrigatorio: () => this.validarCartaoObrigatorio(),
            valorCartaoMenorQueTotal: () => this.validarSomaCartoesInvalida(),
            valorCartaoMaiorQueTotal: () => this.validarSomaCartoesInvalida(),
            valorCartaoNegativo: () => this.validarValorCartaoInvalido(),
            valorCartaoZero: () => this.validarValorCartaoInvalido(),
            valorMinimoCartao: () => this.validarValorMinimoCartao(),

            cupomAplicado: () => this.validarCupomAplicado(),
            cupomTroco: () => this.validarCupomTroco(),

            cartaoBateComResumo: () => this.validarCartaoBateComResumo(),
            botaoFinalizarDesabilitado: () => this.validarBotaoFinalizarDesabilitado(),

            automatico: () => this.validarAutomatico()
        }

        if(!validacoes[tipo]){
            throw new Error(`Validação "${tipo}" não existe no Checkout/TesteIndex.js`)
        }

        validacoes[tipo]()
    }

    preencherCampo(campo, valor){
        this.campos[campo] = valor

        if(campo === 'endereco' || campo === 'cartao1' || campo === 'selectCartao2'){

            cy.get(el.campos[campo])
                .should('exist')
                .should('be.visible')
                .find(`option[value="${valor}"]`)
                .should('exist')

            cy.get(el.campos[campo])
                .select(String(valor))
                .should('have.value', String(valor))
                .trigger('change')

            return
        }

        cy.get(el.campos[campo])
            .clear()
            .type(valor)
            .trigger('input')
            .trigger('change')
    }

    limparCampo(campo){
        cy.get(el.campos[campo])
            .clear()
            .trigger('input')
            .trigger('change')
    }

    marcarCampo(campo){
        this.campos[campo] = true

        cy.get(el.campos[campo])
            .check({ force: true })
            .trigger('change')
    }

    selecionarCupom(id){
        cy.get(
            this.montarSeletorComId(el.cupons.checkbox, id)
        )
            .check({ force: true })
            .trigger('change')
    }

    clicarBotao(botao){
        const botoes = {
            finalizar: () => {
                cy.get(el.botoes.finalizar)
                    .invoke('removeAttr', 'disabled')
                    .click()
            },

            finalizarForcado: () => {
                cy.get(el.botoes.finalizar)
                    .click({ force: true })
            },

            default: () => {
                cy.get(el.botoes[botao])
                    .click()
            }
        }

        if(botoes[botao]){
            botoes[botao]()
            return
        }

        botoes.default()
    }

    preencherValorTotalNoCartao1(){
        cy.get(el.textos.resumoTotal)
            .should('not.contain', '—')
            .should('contain.text', 'R$')
            .invoke('text')
            .then(total => {
                const valor = this.converter(total)

                this.preencherCampo(
                    'valorCartao1',
                    valor.toFixed(2)
                )
            })
    }

    preencherCartoes(valor1, valor2){
        this.preencherCampo('valorCartao1', valor1)

        this.marcarCampo('checkboxCartao2')

        this.preencherCampo('valorCartao2', valor2)
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
        cy.get(el.campos.endereco).should('exist').and('be.visible')
        cy.get(el.campos.cartao1).should('exist').and('be.visible')
        cy.get(el.campos.valorCartao1).should('exist').and('be.visible')

        cy.get(el.textos.resumoFrete).should('exist').and('be.visible')
        cy.get(el.textos.resumoDesconto).should('exist').and('be.visible')
        cy.get(el.textos.resumoTotal).should('exist').and('be.visible')

        cy.get(el.botoes.finalizar).should('exist').and('be.visible')
    }

    validarEndereco(){
        cy.get(el.campos.endereco)
            .should('be.visible')
            .and('not.be.disabled')
    }

    validarEnderecoSelecionado(valorEsperado = null){
        const valor = valorEsperado || this.campos.endereco

        cy.get(el.campos.endereco)
            .should('have.value', valor)
    }

    validarCartao1(){
        cy.get(el.campos.cartao1)
            .should('exist')
            .and('be.visible')
            .and('not.be.disabled')
    }

    validarCartaoSelecionado(valorEsperado){
        cy.get(el.campos.cartao1)
            .should('have.value', valorEsperado)

        cy.get(el.campos.cartao1 + ' option:selected')
            .invoke('text')
            .then(texto => {
                cy.log('Cartão selecionado: ' + texto.trim())
            })
    }

    validarCartao2(){
        cy.get(el.campos.checkboxCartao2)
            .should('exist')
            .and('be.visible')

        this.marcarCampo('checkboxCartao2')

        cy.get(el.campos.selectCartao2)
            .should('be.visible')

        cy.get(el.campos.valorCartao2)
            .should('be.visible')
    }

    validarResumo(){
        cy.get(el.textos.resumoFrete)
            .should('not.contain', '—')
            .and('contain.text', 'R$')

        cy.get(el.textos.resumoDesconto)
            .should('contain.text', 'R$')

        cy.get(el.textos.resumoTotal)
            .should('not.contain', '—')
            .and('contain.text', 'R$')
    }

    validarTotal(){
        cy.get(el.textos.resumoTotal)
            .invoke('text')
            .then(total => {
                const valorTotal = this.converter(total)

                expect(valorTotal).to.be.greaterThan(0)
            })
    }

    validarValorCartao(){
        cy.get(el.campos.valorCartao1)
            .invoke('val')
            .then(valor => {
                expect(Number(valor)).to.be.greaterThan(0)
            })
    }

    validarFrete(){
        cy.get(el.textos.valorFreteCalculado)
            .should('not.contain', 'Calculando')
            .and('contain.text', 'R$')
    }

    validarBotoes(){
        cy.get(el.botoes.voltarCarrinho).should('exist').and('be.visible')
        cy.get(el.botoes.cadastrarEndereco).should('exist').and('be.visible')
        cy.get(el.botoes.cadastrarCartao).should('exist').and('be.visible')
    }

    validarCartaoObrigatorio(){
        cy.get(el.campos.valorCartao1)
            .then(el.validarMensagemNavegador)

        cy.get(el.campos.valorCartao1 + ':invalid')
            .should('exist')
    }

    validarSomaCartoesInvalida(){
        cy.get(el.alertas.valorCartoes)
            .should('be.visible')
            .and('contain.text', 'A soma dos cartões')
    }

    validarValorCartaoInvalido(){
        cy.get(el.campos.valorCartao1)
            .then(el.validarMensagemNavegador)

        cy.get(el.campos.valorCartao1 + ':invalid')
            .should('exist')
    }

    validarValorMinimoCartao(){
        cy.get(el.alertas.minimoCartao)
            .should('be.visible')
            .and('contain.text', 'O valor mínimo por cartão')
    }

    validarCupomAplicado(){
        cy.get(el.textos.resumoDesconto)
            .should('not.contain.text', 'R$ 0,00')
    }

    validarCupomTroco(){
        cy.get(el.alertas.cupomTroco)
            .should('be.visible')
    }

    validarBotaoFinalizarDesabilitado(){
        cy.get(el.botoes.finalizar)
            .should('be.disabled')
    }

    validarCartaoBateComResumo(){
        cy.get(el.textos.resumoTotal)
            .invoke('text')
            .then(totalTexto => {
                const total = this.converter(totalTexto)

                cy.get(el.campos.valorCartao1)
                    .invoke('val')
                    .then(valorCartao => {
                        expect(Number(valorCartao))
                            .to
                            .be
                            .closeTo(total, 0.02)
                    })
            })
    }

    validarAutomatico(){
        cy.url()
            .should('not.eq', el.urls.checkout)
    }
}

export default new Checkout()