export const elements = {
    telaCarrinho:'http://localhost:8080/LES/carrinho',
    telaCarrinhoRegex: /\/LES(\/view)?\/carrinho(\.jsp)?$/,
    campoQuantidade: (item) => `[data-test="campo_quantidade-${item}"]`,
    botaoContinuarComprando: '[data-test=continuar_comprando]',
    botao_atualizar: (item) => `[data-test="botao-atualizar-${item}"]`,
    botao_remover: (item) => `[data-test="botao-remover-${item}"]`,
    botao_logar: '[data-test="botao-logar"]',
    botao_finalizar: '[data-test="botao-finalizar"]'
}