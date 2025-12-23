public class Estoque {

    private String titulo;
    private String autor;
    private String edicao;
    private String isbn;
    private String tamanho;
    private String sinopse;
    private int numPag;
    private double preco;
    private int qtde;
    private Categoria categoria;

    public Estoque(Categoria categoria, String titulo, String autor, String edicao,
                   String isbn, String tamanho, String sinopse,
                   int numPag, double preco, int qtde) {
        this.categoria = categoria;
        this.titulo = titulo;
        this.autor = autor;
        this.edicao = edicao;
        this.isbn = isbn;
        this.tamanho = tamanho;
        this.sinopse = sinopse;
        this.numPag = numPag;
        this.preco = preco;
        this.qtde = qtde;

    }

    public String getTitulo() {
        return titulo;
    }

    public String getAutor() {
        return autor;
    }

    public String getEdicao() {
        return edicao;
    }

    public String getIsbn() {
        return isbn;
    }

    public String getTamanho() {
        return tamanho;
    }

    public String getSinopse() {
        return sinopse;
    }

    public int getNumPag() {
        return numPag;
    }

    public double getPreco() {
        return preco;
    }

    public int getQtde() {
        return qtde;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setQtde(int qtde) {
        this.qtde = qtde;
    }
}