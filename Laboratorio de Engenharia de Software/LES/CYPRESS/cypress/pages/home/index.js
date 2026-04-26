import {elements as el} from "./elements";
class Home {

    visitarPagina(){
        cy.visit(el.telahome)
    }

    validarAcessoPagina(){
        cy.url().should('eq',el.telahome)
    }

    navBarLivros(){
        cy.get(el.navBarLivros).click()
    }
}

export default new Home()