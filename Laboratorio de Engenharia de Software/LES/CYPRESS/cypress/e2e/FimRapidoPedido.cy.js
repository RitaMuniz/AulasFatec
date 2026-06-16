import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import login from "../pages/login/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"
import livrosjson from "../fixtures/livro.json";
import enderecojson from "../fixtures/endereco.json";
import clientejson from "../fixtures/cliente.json";
import cartaojson from "../fixtures/cartao.json";

describe('Fluxo de pedido', () => {

    beforeEach(() => {

        cy.resetarBanco()

        login.visitarPagina()

        login.preencherCampo('username', clientejson["Odete Roitman"].email)

        login.preencherCampo('password', clientejson["Odete Roitman"].senha)

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
            livrosjson["1984"].id
        )

        livro.preencherCampo(
            'quantidade',
            livrosjson["1984"].id,
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
            livrosjson["1984"].id,
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
            enderecojson["dos Bobos"].id
        )

        checkout.preencherCampo(
            'cartao1',
            cartaojson["Odete Roitman Mastercard"].id
        )

        checkout.validar(
            'cartaoSelecionado',
            cartaojson["Odete Roitman Mastercard"].id
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
            livrosjson["1984"].id
        )

        livro.preencherCampo(
            'quantidade',
            livrosjson["1984"].id,
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
            livrosjson["Dom Casmurro"].id
        )

        livro.preencherCampo(
            'quantidade',
            livrosjson["Dom Casmurro"].id,
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
            livrosjson["1984"].id,
            1
        )

        carrinho.validar(
            'quantidade',
            livrosjson["Dom Casmurro"].id,
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
            enderecojson["dos Bobos"].id
        )

        checkout.preencherCampo(
            'cartao1',
            cartaojson["Odete Roitman Visa"].id
        )

        checkout.validar(
            'cartaoSelecionado',
            cartaojson["Odete Roitman Visa"].id
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