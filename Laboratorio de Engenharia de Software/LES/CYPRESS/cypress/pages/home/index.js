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

    navBarCarrinho(){
        cy.get(el.navBarCarrinho).click()
    }
}

export default new Home()