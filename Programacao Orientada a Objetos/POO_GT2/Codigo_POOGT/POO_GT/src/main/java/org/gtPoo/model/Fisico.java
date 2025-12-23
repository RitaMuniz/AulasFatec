package org.gtPoo.model;

public class Fisico extends Livro {

    public Fisico() {
        super();
    }

    public Fisico(String titulo, String isbn, String autor) {
        super(titulo, isbn, autor);
    }

    @Override
    public double calcularMulta(int diasAtraso) {
        return diasAtraso * 2.0;
    }
}