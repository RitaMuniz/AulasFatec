public class Endereco {

    private String logradouro;
    private String numero;
    private String complemento;
    private String cep;
    private String cidade;
    private String estado;
    private String pais;

    public Endereco(String logradouro, String numero, String complemento,
                    String cep, String cidade, String estado, String pais) {
        this.logradouro = logradouro;
        this.numero = numero;
        this.complemento = complemento;
        this.cep = cep;
        this.cidade = cidade;
        this.estado = estado;
        this.pais = pais;
    }

    public void mostrarEndereco() {
        System.out.printf("""
                Endereço: %s, %s, %s, %s - %s/%s CEP %s """, logradouro, numero, complemento, cidade, estado, pais, cep);
    }
}