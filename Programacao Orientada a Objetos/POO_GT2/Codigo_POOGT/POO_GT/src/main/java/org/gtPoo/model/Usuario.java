package org.gtPoo.model;
public class Usuario {

    private int id;
    private String nome;
    private String email;
    private String telefone;
    private String numeroRegistro;
    private String tipo;

    public Usuario() {}

    public Usuario(String nome, String email, String telefone, String numeroRegistro, String tipo) {
        this.nome = nome; this.email = email; this.telefone = telefone;
        this.numeroRegistro = numeroRegistro; this.tipo = tipo;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getNumeroRegistro() {
        return numeroRegistro;
    }

    public void setNumeroRegistro(String numeroRegistro) {
        this.numeroRegistro = numeroRegistro;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) { this.tipo = tipo; }

    @Override
    public String toString() {
        return nome + " (" + numeroRegistro + ")";
    }
}