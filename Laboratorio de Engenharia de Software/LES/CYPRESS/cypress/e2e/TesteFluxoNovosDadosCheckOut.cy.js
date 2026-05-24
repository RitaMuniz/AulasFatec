// cypress/e2e/clienteCadastraEnderecoCartao.cy.js
// ==========================================
// TESTE: Cliente registrar novo cartão e endereço no ato da compra
// ==========================================

import login from "../pages/login/TesteIndex"
import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import endereco from "../pages/Endereco/TesteIndex"
import cartoesPage from "../pages/Cartoes/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"

import usuarios from "../fixtures/usuarios.json"
import livrosDados from "../fixtures/livros.json"

describe('Cliente - Cadastrar Endereço e Cartão no Ato da Compra', () => {

    beforeEach(() => {
        cy.resetarBanco()
    })

    afterEach(() => {
        cy.resetarBanco()
    })

    // ==========================================
    // CENÁRIO 6: Cliente cadastra novo endereço durante o checkout
    // ==========================================
    it('CT06 - Cliente cadastra novo endereço de entrega no ato da compra', () => {
        // Arrange - Login e adicionar ao carrinho
        login.visitarPagina()
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 1)
        livro.clicarBotao('adicionarCarrinho')
        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // Act - Clicar em cadastrar novo endereço
        cy.get('[data-test="botao_cadastrar_endereco"]').click()

        // Preencher novo endereço
        endereco.campo('tipoEndereco', 'ENTREGA')
        endereco.campo('tipoResidencia', 'Apartamento')
        endereco.campo('tipoLogradouro', 'Avenida')
        endereco.campo('logradouro', 'Paulista')
        endereco.campo('numero', '1000')
        endereco.campo('bairro', 'Jardins')
        endereco.campo('cep', '01310-000')
        endereco.campo('cidade', 'São Paulo')
        endereco.campo('estado', '1') // SP
        endereco.campo('observacoes', 'Próximo ao metrô')
        endereco.clicarBotao('salvar')

        // Assert - Voltar ao checkout com novo endereço disponível
        cy.url().should('include', '/pedido')
        cy.get('[data-test="endereco_id"]').should('contain', 'Paulista')

    })

    // ==========================================
    // CENÁRIO 7: Cliente cadastra novo cartão durante o checkout
    // ==========================================
    it('CT07 - Cliente cadastra novo cartão de crédito no ato da compra', () => {
        // Arrange
        login.visitarPagina()
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 1)
        livro.clicarBotao('adicionarCarrinho')
        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', '13')

        // Act - Clicar em cadastrar novo cartão
        cy.get('[data-test="botao_cadastrar_cartao"]').click()

        // Preencher novo cartão
        cartoesPage.campo('nome', 'NOVO CARTAO TESTE')
        cartoesPage.campo('numero', '5555666677778888')
        cartoesPage.campo('validade', '12/28')
        cartoesPage.campo('bandeira', '1') // Mastercard
        cartoesPage.campo('cvv', '123')
        cartoesPage.clicarBotao('adicionar')

        // Assert - Voltar ao checkout e selecionar novo cartão
        cy.url().should('include', '/pedido')
        cy.get('[data-test="cartao1_id"]').should('contain', '**** 8888')

        checkout.preencherCampo('cartao1', '10') // Mastercard
        checkout.preencherCartoes('17.53', '17.53') // Valores divididos
        cy.get('[data-test="checkbox-cartao-2"]').check()
        checkout.preencherCampo('selectCartao2', '11') // novo
        checkout.clicarBotao('finalizar')

    })

    // ==========================================
    // CENÁRIO 8: Cliente deslogado compra, faz login e finaliza
    // ==========================================
    it('CT08 - Cliente não logado adiciona itens, faz login e finaliza compra', () => {
        // Arrange - Sem login
        home.visitarPagina()
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosDados.livro1.id, 1)

        // Act - Tentar finalizar (deve redirecionar para login)
        carrinho.clicarBotao('logar')

        login.validar('estrutura')
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')

        // Assert - Carrinho mantém itens após login
        home.validarAcessoPagina()
        home.clicarMenu('carrinho')
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosDados.livro1.id, 1)

        // Finalizar compra
        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', '13')
        checkout.preencherCampo('cartao1', '10')
        checkout.preencherValorTotalNoCartao1()
        checkout.clicarBotao('finalizar')

        pedidos.validar('confirmacao')
    })
})