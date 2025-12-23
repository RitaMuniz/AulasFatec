package org.gtPoo.model;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Emprestimo {

    private int id;
    private Usuario usuario;
    private Livro livro;
    private LocalDate dataRetirada;
    private LocalDate dataDevolucao;

    public Emprestimo() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Livro getLivro() {
        return livro;
    }

    public void setLivro(Livro livro) {
        this.livro = livro;
    }

    public LocalDate getDataRetirada() {
        return dataRetirada;
    }

    public void setDataRetirada(LocalDate dataRetirada) {
        this.dataRetirada = dataRetirada;
    }

    public LocalDate getDataDevolucao() {
        return dataDevolucao;
    }

    public void setDataDevolucao(LocalDate dataDevolucao) {
        this.dataDevolucao = dataDevolucao;
    }

    public int diasAtraso() {
        if (dataDevolucao == null) return 0;
        long atraso = ChronoUnit.DAYS.between(dataDevolucao, LocalDate.now());
        return (int) Math.max(0, atraso);
    }

    @Override
    public String toString() {
        return livro.getTitulo() + " -> " + usuario.getNome();
    }
}