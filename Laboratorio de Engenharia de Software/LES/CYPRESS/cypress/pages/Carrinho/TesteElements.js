export const elements = {
    urls: {
        carrinho: 'http://localhost:8080/LES/carrinho',
        carrinhoRegex: /\/LES(\/view)?\/carrinho(\.jsp)?$/
    },

    campos: {
        quantidade: '[data-test="campo_quantidade-'
    },

    textos: {
        tituloLivro: '[data-test="titulo-livro-',
        autorLivro: '[data-test="autor-livro-',
        precoUnitario: '[data-test="preco-unitario-livro-',
        precoTotal: '[data-test="preco-total-livro-',
        subtotal: '[data-test="subtotal"]',
        valorFrete: '[data-test="valor-frete"]',
        totalEstimado: '[data-test="total-estimado"]'
    },

    botoes: {
        continuarComprando: '[data-test=continuar_comprando]',
        atualizar: '[data-test="botao-atualizar-',
        remover: '[data-test="botao-remover-',
        logar: '[data-test="botao-logar"]',
        finalizar: '[data-test="botao-finalizar"]'
    },

    textosEsperados: {
        fretePadrao: 'R$ 20,00'
    },

    sufixoDataTest: '"]',

    validarMensagemNavegador($input) {
        expect($input[0].checkValidity()).to.be.false
    }
}