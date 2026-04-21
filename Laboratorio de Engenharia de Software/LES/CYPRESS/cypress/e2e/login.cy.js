describe('Login', () => {


    // cliente logado com sucesso
    it('Realizar login com sucesso', () => {
        // arrange
        cy.visit('http://localhost:8080/LES/view/login.jsp')

        // act
        cy.get('[data-test="email"]').type('ritamuniz1995@gmail.com')
        cy.get('[data-test="senha"]').type('Rita123.')
        cy.get('[data-test="entrar"]').click()
        // assert
        cy.url().should('eq','http://localhost:8080/LES/view/index.jsp')
    })


})