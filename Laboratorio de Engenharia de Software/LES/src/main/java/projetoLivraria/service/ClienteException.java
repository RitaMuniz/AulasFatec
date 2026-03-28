package projetoLivraria.service;

public class ClienteException extends Exception {

    public enum Codigo {
        NOME_INVALIDO,
        CPF_INVALIDO,
        CPF_JA_CADASTRADO,
        EMAIL_JA_CADASTRADO,
        SENHA_FRACA,
        ENDERECO_ENTREGA_AUSENTE,
        ENDERECO_COBRANCA_AUSENTE
    }

    private final Codigo codigo;

    public ClienteException(Codigo codigo, String mensagem) {
        super(mensagem);
        this.codigo = codigo;
    }

    public Codigo getCodigo() {
        return codigo;
    }
}