import {elements as el} from "./elements";

class Login {
    visitarPagina(){
        cy.visit(el.telaLogin)
    }

    preencherCredenciaisSemSenha(){
        cy.get(el.username).type('odete@email.com')
        cy.get(el.loginButton).click()
    }

    preencherCredenciaisSemEmail(){
        cy.get(el.password).type('Odete123!')
        cy.get(el.loginButton).click()
    }

    preencherCredenciaisComCampoVazio(){
        cy.get(el.loginButton).click()
    }

    preencherCredenciaisEmaileSenhaErrado(){
        cy.get(el.username).type('caiqueemailerrado@gmail.com')
        cy.get(el.password).type('Caique123senhaerrada.')
        cy.get(el.loginButton).click()
    }

    preencherCredenciaisSenhaErrada(){
        cy.get(el.username).type('odete@email.com')
        cy.get(el.password).type('SenhaErrada.')
        cy.get(el.loginButton).click()
    }

    preencherCredenciaisEmailErrado(){
        cy.get(el.username).type('ritamunizemailerrado@gmail.com')
        cy.get(el.password).type('Odete123!')
        cy.get(el.loginButton).click()
    }

    preencherCredenciaisInativas(){
        cy.get(el.username).type('aline@email.com')
        cy.get(el.password).type('Aline123!')
        cy.get(el.loginButton).click()
    }

    preencherCredenciaisValidas(){
        cy.get(el.username).type('odete@email.com')
        cy.get(el.password).type('Odete123!')
        cy.get(el.loginButton).click()
    }

    validarCredenciaisClienteInativo(){
        cy.get(el.errorMessageClienteInativo).should('contain.text', 'Sua conta está inativa. Entre em contato com o suporte.')
        cy.url().should('eq', el.linkMessageClienteInativo)
    }

    validarCredenciaisInvalidas(){
        cy.get(el.errorMessageLoginErrado).should('contain.text', 'E-mail ou senha inválidos.')
        cy.url().should('eq', el.linkMessageLoginErrado)
    }

    validarCredenciaisCampoVazio(){
        cy.get(el.username).then(el.validarMensagemNavegador)

        cy.get(el.password).then(el.validarMensagemNavegador)

        cy.get(el.username + ':invalid').should('exist')
        cy.get(el.password + ':invalid').should('exist')
        cy.url().should('eq', el.telaLogin)
    }

    validarCredenciaisSemEmail(){
        cy.get(el.username).then(el.validarMensagemNavegador)


        cy.get(el.username + ':invalid').should('exist')
        cy.url().should('eq', el.telaLogin)
    }

    validarCredenciasSemSenha(){
        cy.get(el.password).then(el.validarMensagemNavegador)

        cy.get(el.password + ':invalid').should('exist')
        cy.url().should('eq', el.telaLogin)
    }

    validarAcessoPagina(){
        cy.url().should('eq', el.telaLogin)
    }
}

export default new Login();