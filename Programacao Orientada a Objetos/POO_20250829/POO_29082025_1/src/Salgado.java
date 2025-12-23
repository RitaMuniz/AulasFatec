/*
* 1 CRIE UMA CLASSE SALGADO COM OS ATRIBUTOS TAMANHO, SABOR E PREÇO JÁ COM OS ATRIBUTOS PRIVADOS E COM OS GETS E SETS
* 2 IMPLEMENTE UM CONSTRUTOR PARA ESTA CLASSE
*/
public class Salgado {
    private String tamanho;
    private String sabor;
    private double preco;

    public Salgado (String tamanho, String sabor, double preco) {
        this.tamanho = tamanho;
        this.sabor = sabor;
        this.preco = preco;
    }
    public String getTamanho() {
        return tamanho;
    }

    public void setTamanho(String tamanho) {
        this.tamanho = tamanho;
    }

    public String getSabor() {
        return sabor;
    }

    public void setSabor(String sabor) {
        this.sabor = sabor;
    }

    public double getPreco() {
        return preco;
    }

    public void setPreco(double preco) {
        this.preco = preco;
    }
}