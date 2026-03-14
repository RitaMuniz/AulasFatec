package projetoLivraria.model;

public class Cartao {
    private String nomeCartao;
    private String nomeCompleto;
    private String bandeira;
    private String cvv;

    public Cartao(String nomeCartao, String nomeCompleto, String bandeira, String cvv) {
        this.nomeCartao = nomeCartao;
        this.nomeCompleto = nomeCompleto;
        this.bandeira = bandeira;
        this.cvv = cvv;
    }

    public String getNomeCartao() {
        return nomeCartao;
    }

    public void setNomeCartao(String nomeCartao) {
        this.nomeCartao = nomeCartao;
    }

    public String getNomeCompleto() {
        return nomeCompleto;
    }

    public void setNomeCompleto(String nomeCompleto) {
        this.nomeCompleto = nomeCompleto;
    }

    public String getBandeira() {
        return bandeira;
    }

    public void setBandeira(String bandeira) {
        this.bandeira = bandeira;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }
}
