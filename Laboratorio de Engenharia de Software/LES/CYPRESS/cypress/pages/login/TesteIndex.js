import { elements as el } from "./TesteElements";

class Login {

    constructor(){
        this.campos = {}
    }

    visitarPagina(){
        this.campos = {}
        cy.visit(el.urls.telaLogin)
    }

    preencherCampo(nome, valor){
        cy.fixture('usuarios').then(dados => {
            const valorFinal = this.obterValorCampo(nome, valor, dados)

            this.campos[nome] = valorFinal

            cy.get(el.campos[nome]).type(valorFinal)
        })
    }

    obterValorCampo(nome, valor, dados){
        if(dados[valor]){
            return dados[valor][el.mapaCamposFixture[nome]]
        }

        return valor
    }

    clicarBotao(botao){
        cy.get(el.botoes[botao]).click()
    }

    validar(tipo = 'automatico'){
        const validacoes = {
            estrutura: () => this.validarEstrutura(),
            atributos: () => this.validarAtributos(),
            camposObrigatorios: () => this.validarCamposObrigatorios(),
            semEmail: () => this.validarCampoObrigatorio('username'),
            semSenha: () => this.validarCampoObrigatorio('password'),
            credenciaisInvalidas: () => this.validarMensagemErro(el.mensagens.erroLogin, el.textos.erroLogin, el.urls.erroLogin),
            clienteInativo: () => this.validarMensagemErro(el.mensagens.erroClienteInativo, el.textos.erroClienteInativo, el.urls.erroClienteInativo),
            emailFormatoInvalido: () => this.validarCampoObrigatorio('username'),
            automatico: () => this.validarAutomatico()
        }

        validacoes[tipo]()
    }

    validarEstrutura(){
        cy.get(el.campos.username).should('exist').and('be.visible')
        cy.get(el.campos.password).should('exist').and('be.visible')
        cy.get(el.botoes.entrar).should('exist').and('be.visible')
    }

    validarAtributos(){
        this.validarAtributosCampo('username')
        this.validarAtributosCampo('password')
    }

    validarAtributosCampo(campo){
        cy.get(el.campos[campo]).should('have.attr', 'type', el.atributos[campo].type)
        cy.get(el.campos[campo]).should('have.attr', 'required')
        cy.get(el.campos[campo]).should('have.attr', 'placeholder', el.atributos[campo].placeholder)
    }

    validarCamposObrigatorios(){
        this.validarCampoObrigatorio('username')
        this.validarCampoObrigatorio('password')
    }

    validarCampoObrigatorio(campo){
        cy.get(el.campos[campo]).then(el.validarMensagemNavegador)
        cy.get(el.campos[campo] + ':invalid').should('exist')
        cy.url().should('eq', el.urls.telaLogin)
    }

    validarMensagemErro(seletor, texto, url){
        cy.get(seletor).should('contain.text', texto)
        cy.url().should('eq', url)
    }

    validarAutomatico(){
        cy.url().then(url => {
            if(url.includes('erro=1')){
                this.validar('credenciaisInvalidas')
                return
            }

            if(url.includes('erro=2')){
                this.validar('clienteInativo')
                return
            }

            cy.get('body').then($body => {
                const emailInvalido = $body.find(el.campos.username + ':invalid').length > 0
                const senhaInvalida = $body.find(el.campos.password + ':invalid').length > 0

                if(emailInvalido && senhaInvalida){
                    this.validar('camposObrigatorios')
                    return
                }

                if(emailInvalido && this.campos.username){
                    this.validar('emailFormatoInvalido')
                    return
                }

                if(emailInvalido){
                    this.validar('semEmail')
                    return
                }

                if(senhaInvalida){
                    this.validar('semSenha')
                    return
                }

                cy.url().should('not.eq', el.urls.telaLogin)
            })
        })
    }
}

export default new Login();