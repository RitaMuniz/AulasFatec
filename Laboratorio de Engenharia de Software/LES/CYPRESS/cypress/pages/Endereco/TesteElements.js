export const elements = {

    regex: {
        endereco: /\/endereco/
    },

    titulo: 'h1',

    navbar: {
        home: 'a[href="index.jsp"]',
        perfil: 'a[href*="/cliente?action=buscar"]',
        sair: 'a[href*="/logout"]'
    },

    campos: {

        tipoEndereco: '[data-test="endereco-tipo"]',

        tipoResidencia: '[data-test="endereco-tipo-residencia"]',

        tipoLogradouro: '[data-test="endereco-tipo-logradouro"]',

        logradouro: '[data-test="endereco-lograduro"]',

        numero: '[data-test="endereco-numero"]',

        bairro: '[data-test="endereco-bairro"]',

        cep: '[data-test="endereco-cep"]',

        cidade: '[data-test="endereco-cidade"]',

        estado: '[data-test="endereco-estado"]',

        observacoes: '[data-test="endereco-observacoes"]'
    },

    botoes: {

        salvar: '[data-test="button-salvar"]',

        cancelar: '[data-test="button-cancelar"]',

        editar: '[data-test="button-editar"]',

        excluir: '[data-test="button-excluir"]'
    },

    tabela: {

        tipoEndereco: '[data-test^="tabela-tipo-endereco-"]',

        logradouro: '[data-test^="tabela-tipo-logradouro-"]',

        numero: '[data-test^="tabela-numero-"]',

        bairro: '[data-test^="tabela-bairro-"]',

        cep: '[data-test^="tabela-cep-"]'
    }
}