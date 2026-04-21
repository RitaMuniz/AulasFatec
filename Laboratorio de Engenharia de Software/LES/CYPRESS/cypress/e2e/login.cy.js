describe('Login', () => {
    // Cliente tenta logar sem preencher senha
    it('Realizar login sem preencher senha', () => {
        // arrange
        cy.visit('http://localhost:8080/LES/view/login.jsp')

        // act
        cy.get('[data-test="email"]').type('ritamuniz1995@gmail.com')
        cy.get('[data-test="entrar"]').click()

        // assert
        cy.get('[data-test="senha"]').then(($input) => {
            expect($input[0].checkValidity()).to.be.false
        })

        cy.get('[data-test="senha"]:invalid').should('exist')
        cy.url().should('eq', 'http://localhost:8080/LES/view/login.jsp')
    })

    // Cliente tenta logar sem preencher email
    it('Realizar login sem preencher email', () => {
        // arrange
        cy.visit('http://localhost:8080/LES/view/login.jsp')

        // act
        cy.get('[data-test="senha"]').type('123456')
        cy.get('[data-test="entrar"]').click()

        // assert
        cy.get('[data-test="email"]').then(($input) => {
            expect($input[0].checkValidity()).to.be.false
        })

        cy.get('[data-test="email"]:invalid').should('exist')
        cy.url().should('eq', 'http://localhost:8080/LES/view/login.jsp')
    })

    // Cliente tenta logar sem preencher nenhum campo
    it('Realizar login sem preencher nenhum campo', () => {
        // arrange
        cy.visit('http://localhost:8080/LES/view/login.jsp')

        // act
        cy.get('[data-test="entrar"]').click()

        // assert
        cy.get('[data-test="email"]').then(($input) => {
            expect($input[0].checkValidity()).to.be.false
        })

        cy.get('[data-test="senha"]').then(($input) => {
            expect($input[0].checkValidity()).to.be.false
        })

        cy.get('[data-test="email"]:invalid').should('exist')
        cy.get('[data-test="senha"]:invalid').should('exist')
        cy.url().should('eq', 'http://localhost:8080/LES/view/login.jsp')
    })

    // Cliente preenche email e senha errado
    it('Realizar login com credenciais invalidas', () => {
        // arrange
        cy.visit('http://localhost:8080/LES/view/login.jsp')

        // act
        cy.get('[data-test="email"]').type('caiqueemailerrado@gmail.com')
        cy.get('[data-test="senha"]').type('Caique123senhaerrada.')
        cy.get('[data-test="entrar"]').click()

        // assert
        cy.get('[data-test="erro_login_errado"]').should('contain.text', 'E-mail ou senha inválidos.')
        cy.url().should('eq', 'http://localhost:8080/LES/view/login.jsp?erro=1')
    })

    // Cliente preenche senha errado
    it('Realizar login com senha errada', () => {
        // arrange
        cy.visit('http://localhost:8080/LES/view/login.jsp')

        // act
        cy.get('[data-test="email"]').type('ritamuniz1995@gmail.com')
        cy.get('[data-test="senha"]').type('SenhaErrada.')
        cy.get('[data-test="entrar"]').click()

        // assert
        cy.get('[data-test="erro_login_errado"]').should('contain.text', 'E-mail ou senha inválidos.')
        cy.url().should('eq', 'http://localhost:8080/LES/view/login.jsp?erro=1')
    })

    // Cliente preenche email inexistente com senha no banco
    it('Realizar login com email inexistente e senha no banco', () => {
        // arrange
        cy.visit('http://localhost:8080/LES/view/login.jsp')

        // act
        cy.get('[data-test="email"]').type('ritamunizemailerrado@gmail.com')
        cy.get('[data-test="senha"]').type('Rita123.')
        cy.get('[data-test="entrar"]').click()

        // assert
        cy.get('[data-test="erro_login_errado"]').should('contain.text', 'E-mail ou senha inválidos.')
        cy.url().should('eq', 'http://localhost:8080/LES/view/login.jsp?erro=1')
    })

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