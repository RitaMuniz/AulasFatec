describe('Variaveis de ambiente',{
    env:{
        id:500
    }
}, () => {
    it('imprimir variavel de ambiente', () => {
        cy.log(Cypress.env('user'))
        cy.log(Cypress.env('host'))
        cy.log(Cypress.env('api_server'))
        cy.log(Cypress.env('id'))
    })
})