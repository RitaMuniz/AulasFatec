package projetoLivraria.model;

import java.sql.Date;

public class Troca {

    public static final String STATUS_SOLICITADA  = "SOLICITADA";
    public static final String STATUS_APROVADA = "APROVADA";
    public static final String STATUS_RECEBIDA = "RECEBIDA";
    public static final String STATUS_CONCLUIDA = "CONCLUIDA";
    public static final String STATUS_RECUSADA = "RECUSADA";

    private int    id;
    private int    pedidoId;
    private int    itemPedidoId;   // qual item do pedido está sendo trocado
    private String status;
    private String motivo;
    private Date   dataSolicitacao;
    private Date   dataRecebimento;
    private Integer cupomGeradoId; // cupom de troca gerado ao concluir

    // objetos carregados por join (opcional)
    private Pedido pedido;
    private ItemPedido itemPedido;
    private Cupom cupomGerado;

    public Troca() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPedidoId() {
        return pedidoId;
    }

    public void setPedidoId(int pedidoId) {
        this.pedidoId = pedidoId;
    }

    public int getItemPedidoId() {
        return itemPedidoId;
    }

    public void setItemPedidoId(int id) {
        this.itemPedidoId = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public Date getDataSolicitacao() {
        return dataSolicitacao;
    }

    public void setDataSolicitacao(Date d) {
        this.dataSolicitacao = d;
    }

    public Date getDataRecebimento() {
        return dataRecebimento;
    }

    public void setDataRecebimento(Date d) {
        this.dataRecebimento = d;
    }

    public Integer getCupomGeradoId() {
        return cupomGeradoId;
    }

    public void setCupomGeradoId(Integer id) {
        this.cupomGeradoId = id;
    }

    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido p) {
        this.pedido = p;
    }

    public ItemPedido getItemPedido() {
        return itemPedido;
    }

    public void setItemPedido(ItemPedido i) {
        this.itemPedido = i;
    }

    public Cupom getCupomGerado() {
        return cupomGerado;
    }

    public void setCupomGerado(Cupom c) {
        this.cupomGerado = c;
    }
}