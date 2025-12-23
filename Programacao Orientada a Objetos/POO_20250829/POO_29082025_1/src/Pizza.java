/*
* 4 CRIE UMA CLASSE PIZZA QUE HERDE OS ATRIBUTOS DE SALGADO E ACRESCENTE O ATRIBUTO RODIZIO
*/
public class Pizza extends Salgado {

    private boolean rodizio;

    //2
    public Pizza (String piTamanho, String piSabor, double piPreco, boolean rodizio) {
        super(piTamanho, piSabor, piPreco);
        this.rodizio = rodizio;
    }

    public void exibePizza() {
        System.out.printf("""
                \nPizza
                 Tamanho: %s,
                 Sabor: %s
                 Preco: %.2f
                 Rodizio: %s""", getTamanho(), getSabor(), getPreco(), isRodizio());
    }

    public boolean isRodizio() {
        return rodizio;
    }

    public void setRodizio(boolean rodizio) {
        this.rodizio = rodizio;
    }
}