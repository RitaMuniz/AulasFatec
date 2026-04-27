import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import login from "../pages/login/TesteIndex"

describe('Checkout', () => {

    beforeEach(() => {

        // arrange
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
            3
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
            7
        )

        livro.clicarBotao(
            'adicionarCarrinho'
        )

        carrinho.validar(
            'acessoPagina'
        )

        carrinho.clicarBotao(
            'finalizar'
        )

        checkout.validar(
            'estrutura'
        )
    })


    afterEach(() => {
        cy.resetarBanco()
    })


    it('Validar estrutura do checkout', () => {

        // assert
        checkout.validar(
            'estrutura'
        )
    })


    it('Exibir endereço de entrega', () => {

        // assert
        checkout.validar(
            'endereco'
        )
    })


    it('Selecionar endereço', () => {

        // act
        checkout.preencherCampo(
            'endereco',
            '5'
        )

        // assert
        checkout.validar(
            'enderecoSelecionado'
        )
    })


    it('Validar resumo financeiro', () => {

        // assert
        checkout.validar(
            'resumo'
        )

        checkout.validar(
            'total'
        )
    })


    it('Validar frete calculado', () => {

        // assert
        checkout.validar(
            'freteCalculado'
        )
    })


    it('Validar cartão principal', () => {

        // assert
        checkout.validar(
            'cartao1'
        )
    })


    it('Validar segundo cartão', () => {

        // assert
        checkout.validar(
            'cartao2'
        )
    })


    it('Validar botões auxiliares', () => {

        // assert
        checkout.validar(
            'botoesAuxiliares'
        )
    })


    it('Preencher valor total no cartão', () => {

        // act
        checkout.validar(
            'resumo'
        )

        checkout.preencherValorTotalNoCartao1()

        // assert
        checkout.validar(
            'valorCartao'
        )

        checkout.validar(
            'cartaoBateComResumo'
        )
    })


    it('Não finalizar sem preencher valor do cartão', () => {

        // act
        checkout.preencherCampo(
            'endereco',
            '5'
        )

        checkout.limparCampo(
            'valorCartao1'
        )

        checkout.clicarBotao(
            'finalizarForcado'
        )

        // assert
        checkout.validar(
            'cartaoObrigatorio'
        )
    })


    it('Exibir erro quando valor do cartão for menor que total', () => {

        // act
        checkout.preencherCampo(
            'endereco',
            '5'
        )

        checkout.preencherCampo(
            'valorCartao1',
            '10.00'
        )

        // assert
        checkout.validar(
            'valorCartaoMenorQueTotal'
        )

        checkout.validar(
            'botaoFinalizarDesabilitado'
        )
    })


    it('Exibir erro quando valor do cartão for maior que total', () => {

        // act
        checkout.preencherCampo(
            'endereco',
            '5'
        )

        checkout.preencherCampo(
            'valorCartao1',
            '9999.00'
        )

        // assert
        checkout.validar(
            'valorCartaoMaiorQueTotal'
        )

        checkout.validar(
            'botaoFinalizarDesabilitado'
        )
    })


    it('Não aceitar valor negativo no cartão', () => {

        // act
        checkout.preencherCampo(
            'endereco',
            '5'
        )

        checkout.preencherCampo(
            'valorCartao1',
            '-10'
        )

        // assert
        checkout.validar(
            'valorCartaoNegativo'
        )
    })


    it('Não aceitar valor zero no cartão', () => {

        // act
        checkout.preencherCampo(
            'endereco',
            '5'
        )

        checkout.preencherCampo(
            'valorCartao1',
            '0'
        )

        // assert
        checkout.validar(
            'valorCartaoZero'
        )
    })


    it('Exibir erro quando soma dos dois cartões for diferente do total', () => {

        // act
        checkout.preencherCampo(
            'endereco',
            '5'
        )

        checkout.preencherCartoes(
            '10.00',
            '10.00'
        )

        // assert
        checkout.validar(
            'valorCartaoMenorQueTotal'
        )

        checkout.validar(
            'botaoFinalizarDesabilitado'
        )
    })


    it('Exibir erro quando cartão tiver valor abaixo do mínimo', () => {

        // act
        checkout.preencherCampo(
            'endereco',
            '5'
        )

        checkout.preencherCartoes(
            '5.00',
            '224.67'
        )

        // assert
        checkout.validar(
            'valorMinimoCartao'
        )

        checkout.validar(
            'botaoFinalizarDesabilitado'
        )
    })


    it('Aplicar cupom de desconto', () => {

        // act
        checkout.selecionarCupom(
            6
        )

        // assert
        checkout.validar(
            'cupomAplicado'
        )

        checkout.validar(
            'resumo'
        )
    })


    it('Voltar para carrinho', () => {

        // act
        checkout.clicarBotao(
            'voltarCarrinho'
        )

        // assert
        carrinho.validar(
            'acessoPagina'
        )
    })


    it('Finalizar pedido com sucesso', () => {

        // arrange
        checkout.preencherCampo(
            'endereco',
            '5'
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

        // act
        checkout.clicarBotao(
            'finalizar'
        )

        // assert
        checkout.validar()
    })

})