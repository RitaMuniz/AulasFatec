export const elements = {

    urls: {
        checkout: 'http://localhost:8080/LES/pedido',
        carrinho: 'http://localhost:8080/LES/carrinho'
    },

    campos: {
        endereco: '[data-test="endereco_id"]',
        cartao1: '[data-test="cartao1_id"]',
        valorCartao1: '[data-test="input-valor-cartao-1"]',

        checkboxCartao2: '[data-test="checkbox-cartao-2"]',
        selectCartao2: '[data-test="select-cartao-2"]',
        valorCartao2: '[data-test="input-valor-cartao-2"]'
    },

    textos: {
        resumoTotal: '[data-test="resumo-total"]',
        resumoFrete: '[data-test="resumo-frete"]',
        resumoDesconto: '[data-test="resumo-desconto"]',
        valorFreteCalculado: '[data-test="valor_frete_calculado"]'
    },

    alertas: {
        valorCartoes: '[data-test="alerta-valor-cartoes"]',
        minimoCartao: '[data-test="alerta-minimo-cartao"]',
        cupom: '[data-test="alerta-cupom"]',
        cupomTroco: '[data-test="alerta-cupom-troco"]'
    },

    botoes: {
        finalizar: '[data-test="botao_finalizar"]',
        voltarCarrinho: '[data-test="voltar-carrinho"]',
        cadastrarEndereco: '[data-test="botao_cadastrar_endereco"]',
        cadastrarCartao: '[data-test="botao_cadastrar_cartao"]'
    },

    cupons: {
        item: '[data-test="item-cupom-',
        checkbox: '[data-test="cupom-'
    },

    sufixoDataTest: '"]',

    validarMensagemNavegador($input){
        expect($input[0].checkValidity()).to.be.false
    }
}