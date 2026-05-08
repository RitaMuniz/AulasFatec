package projetoLivraria.model;

import java.math.BigDecimal;

public class Cupom {

    public static final String TIPO_PROMOCIONAL = "PROMOCIONAL";
    public static final String TIPO_TROCA       = "TROCA";

    public static final String STATUS_DISPONIVEL = "DISPONIVEL";
    public static final String STATUS_USADO      = "USADO";

    private int id;
    private String codigo;
    private BigDecimal valor;
    private String tipo;   // PROMOCIONAL | TROCA
    private String status; // DISPONIVEL  | USADO
    private int clienteId;

    public Cupom() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getClienteId() {
        return clienteId;
    }

    public void setClienteId(int id) {
        this.clienteId = id;
    }

    //helpers
    public boolean isPromocional() {
        return TIPO_PROMOCIONAL.equals(tipo);
    }

    public boolean isTroca() {
        return TIPO_TROCA.equals(tipo);
    }

    public boolean isDisponivel() {
        return STATUS_DISPONIVEL.equals(status);
    }

}