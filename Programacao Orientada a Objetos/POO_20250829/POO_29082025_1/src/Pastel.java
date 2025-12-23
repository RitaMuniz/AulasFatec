/*
* 3 CRIE UMA CLASSE PASTEL QUE HERDE OS ATRIBUTOS DE SALGADO
*/
public class Pastel extends Salgado {

    public Pastel (String paTamanho, String paSabor, double paPreco) {
        super(paTamanho, paSabor, paPreco);
    }

    public void exibePastel() {
        System.out.printf("""
                \nPastel
                 Tamanho: %s,
                 Sabor: %s
                 Preco: %.2f""", getTamanho(), getSabor(), getPreco());
    }
}