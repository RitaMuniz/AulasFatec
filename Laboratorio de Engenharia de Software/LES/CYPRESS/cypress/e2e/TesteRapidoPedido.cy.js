import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import login from "../pages/login/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"

describe('Fluxo de pedido', () => {

    beforeEach(() => {

        cy.resetarBanco()

        login.visitarPagina()

        login.preencherCampo(
            'username',
            'maria'
        )

        login.preencherCampo(
            'password',
            'maria'
        )

        login.clicarBotao(
            'entrar'
        )

        home.validarAcessoPagina()
    })


    afterEach(() => {
        cy.resetarBanco()
    })


    it('Comprar 1 item com Mastercard', () => {

        // passo 1
        home.clicarMenu('livros')

        livros.clicarBotao(
            'detalhesLivro',
            1
        )

        livro.preencherCampo(
            'quantidade',
            1,
            1
        )

        livro.clicarBotao(
            'adicionarCarrinho'
        )

        carrinho.validar(
            'acessoPagina'
        )

        carrinho.validar(
            'quantidade',
            1,
            1
        )

        // passo 2
        carrinho.clicarBotao(
            'finalizar'
        )

        checkout.validar(
            'estrutura'
        )

        // passo 3
        checkout.preencherCampo(
            'endereco',
            '5'
        )

        checkout.preencherCampo(
            'cartao1',
            '10'
        )

        checkout.validar(
            'cartaoSelecionado',
            '10'
        )

        checkout.validar(
            'resumo'
        )

        checkout.preencherValorTotalNoCartao1()

        checkout.validar(
            'valorCartao'
        )

        checkout.validar(
            'cartaoBateComResumo'
        )

        // passo 4 e 5
        checkout.clicarBotao(
            'finalizar'
        )

        pedidos.validar(
            'confirmacao'
        )

        pedidos.clicarBotao(
            'meusPedidos'
        )

        pedidos.validar(
            'pedidoCadastrado'
        )

        pedidos.clicarBotao(
            'detalhesPedido'
        )

        pedidos.validar(
            'detalhePedido'
        )

        pedidos.validar(
            'statusConfirmado'
        )
    })



    it('Comprar 2 itens com VISA', () => {

        home.clicarMenu(
            'livros'
        )

        livros.clicarBotao(
            'detalhesLivro',
            1
        )

        livro.preencherCampo(
            'quantidade',
            1,
            1
        )

        livro.clicarBotao(
            'adicionarCarrinho'
        )

        carrinho.clicarBotao(
            'continuarComprando'
        )

        livros.clicarBotao(
            'detalhesLivro',
            2
        )

        livro.preencherCampo(
            'quantidade',
            2,
            1
        )

        livro.clicarBotao(
            'adicionarCarrinho'
        )

        carrinho.validar(
            'acessoPagina'
        )

        carrinho.validar(
            'quantidade',
            1,
            1
        )

        carrinho.validar(
            'quantidade',
            2,
            1
        )

        carrinho.clicarBotao(
            'finalizar'
        )

        checkout.validar(
            'estrutura'
        )

        checkout.preencherCampo(
            'endereco',
            '5'
        )

        checkout.preencherCampo(
            'cartao1',
            '8'
        )

        checkout.validar(
            'cartaoSelecionado',
            '8'
        )

        checkout.validar(
            'resumo'
        )

        checkout.preencherValorTotalNoCartao1()

        checkout.validar(
            'valorCartao'
        )

        checkout.validar(
            'cartaoBateComResumo'
        )

        checkout.clicarBotao(
            'finalizar'
        )

        pedidos.validar(
            'confirmacao'
        )

        pedidos.clicarBotao(
            'meusPedidos'
        )

        pedidos.validar(
            'pedidoCadastrado'
        )

        pedidos.clicarBotao(
            'detalhesPedido'
        )

        pedidos.validar(
            'detalhePedido'
        )

        pedidos.validar(
            'statusConfirmado'
        )
    })

})