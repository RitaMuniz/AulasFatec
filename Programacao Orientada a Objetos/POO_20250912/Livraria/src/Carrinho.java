import java.util.ArrayList;
import java.util.List;

public class Carrinho {

    private List<ItemCarrinho> itens;

    public Carrinho() {
        this.itens = new ArrayList<>();
    }

    public void adicionar(Estoque estoque, int quantidade) {
        if (estoque.getQtde() < quantidade) {
            System.out.println("Estoque insuficiente para " + estoque.getTitulo());
            return;
        }

        for (ItemCarrinho item : itens) {
            if (item.getLivro().equals(estoque)) {
                item.adicionarQuantidade(quantidade);
                estoque.setQtde(estoque.getQtde() - quantidade);
                System.out.println("Adicionado +" + quantidade + " de " + estoque.getTitulo());
                return;
            }
        }

        itens.add(new ItemCarrinho(estoque, quantidade));
        estoque.setQtde(estoque.getQtde() - quantidade); // baixa do estoque
        System.out.println(estoque.getTitulo() + " x" + quantidade + " adicionado ao carrinho.");
    }


    public void remover(Estoque produto, int quantidade) {
        for (ItemCarrinho item : itens) {
            if (item.getLivro().equals(produto)) {
                if (quantidade >= item.getQuantidade()) {
                    itens.remove(item);
                    produto.setQtde(produto.getQtde() + item.getQuantidade());
                    System.out.println(produto.getTitulo() + " removido do carrinho.");
                } else {
                    item.removerQuantidade(quantidade);
                    produto.setQtde(produto.getQtde() + quantidade);
                    System.out.println("Removido " + quantidade + " de " + produto.getTitulo());
                }
                return;
            }
        }
        System.out.println("Produto não encontrado no carrinho.");
    }

    public void listar() {
        if (itens.isEmpty()) {
            System.out.println("Carrinho vazio.");
            return;
        }

        System.out.println("\nProdutos no carrinho:");
        for (ItemCarrinho item : itens) {
            System.out.printf("""
                                    ------------------------------------------------------------------------------------
                                    Titulo: %s
                                    Preco: %.2f
                                    Qtde: %d
                                    ------------------------------------------------------------------------------------
                                    """, item.getLivro().getTitulo(), item.getLivro().getPreco(), item.getQuantidade());
        }
        System.out.println("Total: R$ " + total());
    }

    public double total() {
        double total = 0;
        for (ItemCarrinho item : itens) {
            total += item.getSubtotal();
        }
        return total;
    }
}