public class Materiais {

    private TipoMateriais tipo;
    private String nome;
    private int quantidade;

    public Materiais(TipoMateriais tipo, String nome, int quantidade) {
        this.tipo = tipo;
        this.nome = nome;
        this.quantidade = quantidade;
    }

    public boolean usar(int qtd) {
        if (qtd <= quantidade) {
            quantidade -= qtd;
            return true;
        }
        return false;
    }

    public String getNome() {
        return nome;
    }

    public TipoMateriais getTipo() {
        return tipo;
    }

    @Override
    public String toString() {
        return tipo + " - " + nome + " | qtd: " + quantidade;
    }
}