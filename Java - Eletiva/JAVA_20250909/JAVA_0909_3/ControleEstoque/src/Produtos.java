public class Produtos {

    private String produto;
    private int qtdEstoque;
    private double preco;
    private int qtdAviso;
    private int qtdVendido;
    private double totalFaturado;
    private double lucroLiquido;
    private double lucro;
    private double custo;
    private boolean aviso = false;
    private boolean aviso2 = false;

    public Produtos(String produto, int qtdEstoque, double preco, double lucro) {
        this.produto = produto;
        this.qtdEstoque = qtdEstoque;
        this.preco = preco;
        this.lucro = lucro;
        this.qtdAviso = (int) Math.ceil(qtdEstoque * 0.2);
        this.qtdVendido = 0;
        this.custo = 0;
    }

    public void compra(int qtd) {
        if (this.qtdEstoque >= qtd) {
            this.qtdEstoque -= qtd;
            this.qtdVendido += qtd;
            this.totalFaturado += qtd * this.preco;
            this.custo += qtd * (this.preco / (1+lucro));
            this.lucroLiquido = this.totalFaturado - this.custo;
        }

        if (this.qtdEstoque <= qtdAviso && this.qtdEstoque > 0 && !aviso) {
            System.out.println("Aviso: O produto %s está quase acabando".formatted(this.produto));
            aviso = true;
        }

        if (this.qtdEstoque == 0 && !aviso2) {
            System.out.println("Aviso: O produto %s acabou!".formatted(this.produto));
            aviso2 = true;
        }
    }

    public int getQtdVendido() {
        return qtdVendido;
    }

    public double getTotalFaturado() {
        return totalFaturado;
    }

    public double getLucroLiquido() {
        return lucroLiquido;
    }

    public double getCusto() {
        return custo;
    }
}