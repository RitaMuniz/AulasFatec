package projetoLivraria.model;

public class Cartao {
    private int id;
    private int clienteId;
    private String numero;
    private String nomeImpresso;
    private int bandeiraId;
    private String bandeiraNome; // para exibição, não vai ao banco
    private String validade;
    private String cvv;

    public Cartao() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getClienteId() { return clienteId; }
    public void setClienteId(int clienteId) { this.clienteId = clienteId; }

    public String getNumero() { return numero; }
    public void setNumero(String numero) { this.numero = numero; }

    public String getNomeImpresso() { return nomeImpresso; }
    public void setNomeImpresso(String nomeImpresso) { this.nomeImpresso = nomeImpresso; }

    public int getBandeiraId() { return bandeiraId; }
    public void setBandeiraId(int bandeiraId) { this.bandeiraId = bandeiraId; }

    public String getBandeiraNome() { return bandeiraNome; }
    public void setBandeiraNome(String bandeiraNome) { this.bandeiraNome = bandeiraNome; }

    public String getValidade() { return validade; }
    public void setValidade(String validade) { this.validade = validade; }

    public String getCvv() { return cvv; }
    public void setCvv(String cvv) { this.cvv = cvv; }
}