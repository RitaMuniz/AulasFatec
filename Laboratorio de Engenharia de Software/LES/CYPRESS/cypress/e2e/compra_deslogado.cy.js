import home from "../pages/home";
import livros from "../pages/Livros";
import livro from "../pages/Livro";
import carrinho from "../pages/Carrinho";
import login from "../pages/login";
import checkout from "../pages/Checkout";

describe('Fluxo Completo Compra', () => {

    function etapa(nome, fluxo) {
        cy.log('')
        cy.log('')
        cy.log('')
        cy.log(nome)
        cy.log('')
        cy.log('')
        cy.log('')
        fluxo()
    }

    it('Jornada completa do cliente com erros de login e carrinho', () => {
        cy.resetarBanco();
        etapa('ETAPA 9 - IR AO PRODUTO E VOLTAR', () => {
            home.visitarPagina()
            home.navBarLivros()
            livros.buttonVerDetalhesDoLivro(1)
            livro.backButton()
            livros.validarAcessoPagina()
        })

        etapa('ETAPA 10 - TESTAR QUANTIDADE NEGATIVA', () => {
            livros.buttonVerDetalhesDoLivro(1)
            livro.preencherQuantidade(1, -3)
            livro.buttonAdicionarAoCarrinho()
            livro.validarQuantidadeInvalida(1)
        })

        etapa('ETAPA 11 - TESTAR QUANTIDADE ZERADA', () => {
            livro.preencherQuantidade(1, 0)
            livro.buttonAdicionarAoCarrinho()
            livro.validarQuantidadeInvalida(1)
        })

        etapa('ETAPA 12 - TESTAR ACIMA DO ESTOQUE', () => {
            livro.preencherQuantidade(1, 100)
            livro.buttonAdicionarAoCarrinho()
            livro.validarQuantidadeInvalida(1)
        })

        etapa('ETAPA 13 - ADICIONAR PRIMEIRO PRODUTO', () => {
            livro.preencherQuantidade(1, 3)
            livro.buttonAdicionarAoCarrinho()

            carrinho.validarAcessoPagina()
            carrinho.validarCampoQuantidade(1, 3)
        })

        etapa('ETAPA 14 - CONTINUAR COMPRANDO SEGUNDO PRODUTO', () => {
            carrinho.buttonContinuarComprando()
            livros.buttonVerDetalhesDoLivro(2)
            livro.preencherQuantidade(2, 10)
            livro.buttonAdicionarAoCarrinho()

            carrinho.validarCampoQuantidade(1, 3)
            carrinho.validarCampoQuantidade(2, 10)
        })

        etapa('ETAPA 15 - TESTAR UPDATE ACIMA DO ESTOQUE', () => {
            carrinho.alterarCampoQuantidade(1, 70)
            carrinho.buttonAtualizar(1)
            carrinho.validarCampoQuantidadeInvalida(1)
        })

        etapa('ETAPA 16 - TESTAR UPDATE COM ZERO', () => {
            carrinho.alterarCampoQuantidade(2, 0)
            carrinho.buttonAtualizar(2)
            carrinho.validarCampoQuantidadeInvalida(2)
        })

        etapa('ETAPA 17 - TESTAR UPDATE NEGATIVO', () => {
            carrinho.alterarCampoQuantidade(2, -10)
            carrinho.buttonAtualizar(2)
            carrinho.validarCampoQuantidadeInvalida(2)
        })

        etapa('ETAPA 18 - ATUALIZAR QUANTIDADE CORRETA', () => {
            carrinho.alterarCampoQuantidade(2, 7)
            carrinho.buttonAtualizar(2)

            carrinho.validarCampoQuantidade(1, 3)
            carrinho.validarCampoQuantidade(2, 7)
        })

        etapa('ETAPA 19 - REMOVER ITEM DO CARRINHO', () => {
            carrinho.buttonRemover(1)
            carrinho.validarCampoQuantidade(2, 7)
        })

        etapa('ETAPA 20 - ADICIONAR ITEM REMOVIDO NOVAMENTE', () => {
            carrinho.buttonContinuarComprando()
            livros.buttonVerDetalhesDoLivro(1)
            livro.preencherQuantidade(1, 23)
            livro.buttonAdicionarAoCarrinho()

            carrinho.validarCampoQuantidade(1, 23)
            carrinho.validarCampoQuantidade(2, 7)
        })

        etapa('ETAPA 21 - ADICIONAR ITEM EXISTENTE ACIMA DO ESTOQUE', () => {
            carrinho.buttonContinuarComprando()
            livros.buttonVerDetalhesDoLivro(1)
            livro.preencherQuantidade(1, 43)
            livro.buttonAdicionarAoCarrinho()

            carrinho.validarCampoQuantidade(1, 44)
            carrinho.validarCampoQuantidade(2, 7)

        })

        etapa('ETAPA 22 - ATUALIZAR QUANTIDADE CORRETA', () => {
            carrinho.alterarCampoQuantidade(1, 3)
            carrinho.buttonAtualizar(1)
            carrinho.alterarCampoQuantidade(2, 2)
            carrinho.buttonAtualizar(2)

            carrinho.validarCampoQuantidade(1, 3)
            carrinho.validarCampoQuantidade(2, 2)
            carrinho.buttonLogar()
        })

        cy.log('LOGIN')

        etapa('ETAPA 1 - LOGIN SEM SENHA', () => {
            login.visitarPagina()
            login.preencherCredenciaisSemSenha()
            login.validarCredenciasSemSenha()
        })

        etapa('ETAPA 2 - LOGIN SEM EMAIL', () => {
            login.visitarPagina()
            login.preencherCredenciaisSemEmail()
            login.validarCredenciaisSemEmail()
        })

        etapa('ETAPA 3 - LOGIN COM CAMPOS VAZIOS', () => {
            login.visitarPagina()
            login.preencherCredenciaisComCampoVazio()
            login.validarCredenciaisCampoVazio()
        })

        etapa('ETAPA 4 - LOGIN COM EMAIL E SENHA ERRADOS', () => {
            login.visitarPagina()
            login.preencherCredenciaisEmaileSenhaErrado()
            login.validarCredenciaisInvalidas()
        })

        etapa('ETAPA 5 - LOGIN COM SENHA ERRADA', () => {
            login.visitarPagina()
            login.preencherCredenciaisSenhaErrada()
            login.validarCredenciaisInvalidas()
        })

        etapa('ETAPA 6 - LOGIN COM EMAIL INEXISTENTE', () => {
            login.visitarPagina()
            login.preencherCredenciaisEmailErrado()
            login.validarCredenciaisInvalidas()
        })

        etapa('ETAPA 7 - LOGIN COM CLIENTE INATIVO', () => {
            login.visitarPagina()
            login.preencherCredenciaisInativas()
            login.validarCredenciaisClienteInativo()
        })

        etapa('ETAPA 8 - LOGIN COM SUCESSO', () => {
            login.visitarPagina()
            login.preencherCredenciaisValidas()
            home.validarAcessoPagina()
        })

        etapa('ETAPA 8.1 - Acessar Carrinho', () => {
            home.navBarCarrinho()
            carrinho.validarAcessoPagina()
        })

        etapa('ETAPA 8.2 - Finalizar compra', () => {
            carrinho.buttonFinalizar()
        })

        //etapa('ETAPA 8.3 - comprar', () => {
        //    carrinho.buttonFinalizar()
        //})

        etapa('ETAPA 22 - Finalizar compra', () => {
            checkout.preencherValorTotalNoCartao1()
            checkout.buttonFinalizar()


            cy.resetarBanco();


        })





    })

})