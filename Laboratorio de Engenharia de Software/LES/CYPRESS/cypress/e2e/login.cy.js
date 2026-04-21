describe('Login', () => {


    // cliente esta inativo
    it('Realizar login com cliente inativo', () => {
        // arrange
        cy.visit('http://localhost:8080/LES/view/login.jsp')

        // act
        cy.get('[data-test="email"]').type('odeteroitman@gmail.com')
        cy.get('[data-test="senha"]').type('odete123')
        cy.get('[data-test="entrar"]').click()

        // assert
        cy.get('[data-test="erro_cliente_inativo"]').should('contain.text', 'Sua conta está inativa. Entre em contato com o suporte.')
        cy.url().should('eq', 'http://localhost:8080/LES/view/login.jsp?erro=2')
    })

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