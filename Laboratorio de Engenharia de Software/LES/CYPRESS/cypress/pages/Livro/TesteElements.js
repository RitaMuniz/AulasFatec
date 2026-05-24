export const elements = {
    urls: {
        livro: 'http://localhost:8080/LES/livro?id='
    },

    campos: {
        quantidade: '[data-test=input-quantidade-'
    },

    textos: {
        estoque: '[data-test="text-estoque-',
        quantidadeDisponivel: '[data-test="quantidade_livros_disponivel"]'
    },

    botoes: {
        voltar: '[data-test="botao_voltar"]',
        adicionarCarrinho: '[data-test="adicionar_carrinho"]'
    },

    sufixoColchete: ']',
    sufixoDataTest: '"]',

    validarMensagemNavegador($input) {
        expect($input[0].checkValidity()).to.be.false
    }
}