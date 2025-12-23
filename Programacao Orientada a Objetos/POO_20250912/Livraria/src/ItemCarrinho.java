public class ItemCarrinho {

    private Estoque livro;
    private int quantidade;

    public ItemCarrinho(Estoque livro, int quantidade) {
        this.livro = livro;
        this.quantidade = quantidade;
    }

    public Estoque getLivro() {
        return livro;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void adicionarQuantidade(int q) {
        this.quantidade += q;
    }

    public void removerQuantidade(int q) {
        this.quantidade -= q;
    }

    public double getSubtotal() {
        return livro.getPreco() * quantidade;
    }
}
