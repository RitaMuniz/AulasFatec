package org.gtPoo.model;

public class Ebook extends Livro {
    public Ebook() { super(); }
    public Ebook(String titulo, String isbn, String autor) { super(titulo, isbn, autor); }

    @Override
    public double calcularMulta(int diasAtraso) {
        return diasAtraso * 0.5; // R$0.5 por dia, por exemplo
    }
}