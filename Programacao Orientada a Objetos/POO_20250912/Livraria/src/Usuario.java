public class Usuario extends Endereco {

    private String nome;
    private String contato;
    private String cpf;

    public Usuario(String nome, String contato, String cpf,
                   String logradouro, String numero, String complemento,
                   String cep, String cidade, String estado, String pais) {

        super (logradouro, numero, complemento, cep, cidade, estado, pais);
        this.nome = nome;
        this.contato = contato;
        this.cpf = cpf;
    }

    public void mostrarDados() {
        System.out.printf("""
                Dados:
                Nome: %s
                CPF: %s
                Contato: %s
                 """, nome, cpf, contato);
        mostrarEndereco();
    }

    public String getNome() {
        return nome;
    }

    public String getContato() {
        return contato;
    }

    public String getCpf() {
        return cpf;
    }
}