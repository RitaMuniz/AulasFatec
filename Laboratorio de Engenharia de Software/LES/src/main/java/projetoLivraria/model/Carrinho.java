package projetoLivraria.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Carrinho {

    private int id;
    private int clienteId;
    private Cliente cliente;
    private List<ItemCarrinho> itens = new ArrayList<>();
    private BigDecimal subtotal = BigDecimal.ZERO;
    private BigDecimal frete = BigDecimal.ZERO;
    private BigDecimal desconto = BigDecimal.ZERO;
    private BigDecimal total = BigDecimal.ZERO;
    private String status;
    private Timestamp dataCriacao;
    private Timestamp dataAtualizacao;
    private Timestamp dataExpiracao;

    public Carrinho() {}

    /**
     * Adiciona um livro ao carrinho (sessão).
     * Se o livro já existir, incrementa a quantidade.
     */
    public void adicionarItem(Livro livro) {
        for (ItemCarrinho item : itens) {
            if (item.getLivroId() == livro.getId()) {
                item.setQuantidade(item.getQuantidade() + 1);
                item.setSubtotal(livro.getPrecoVenda().multiply(BigDecimal.valueOf(item.getQuantidade())));
                recalcularTotais();
                return;
            }
        }
        ItemCarrinho novo = new ItemCarrinho();
        novo.setLivroId(livro.getId());
        novo.setLivro(livro);
        novo.setQuantidade(1);
        novo.setPrecoUnitario(livro.getPrecoVenda());
        novo.setSubtotal(livro.getPrecoVenda());
        itens.add(novo);
        recalcularTotais();
    }

    public void removerItem(int livroId) {
        itens.removeIf(item -> item.getLivroId() == livroId);
        recalcularTotais();
    }

    public void recalcularTotais() {
        subtotal = itens.stream()
                .map(ItemCarrinho::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        total = subtotal.add(frete).subtract(desconto);
    }

    public int getTotalItens() {
        return itens.stream().mapToInt(ItemCarrinho::getQuantidade).sum();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getClienteId() { return clienteId; }
    public void setClienteId(int clienteId) { this.clienteId = clienteId; }

    public Cliente getCliente() { return cliente; }
    public void setCliente(Cliente cliente) { this.cliente = cliente; }

    public List<ItemCarrinho> getItens() { return itens; }
    public void setItens(List<ItemCarrinho> itens) {
        this.itens = itens;
        recalcularTotais();
    }

    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }

    public BigDecimal getFrete() { return frete; }
    public void setFrete(BigDecimal frete) {
        this.frete = frete;
        recalcularTotais();
    }

    public BigDecimal getDesconto() { return desconto; }
    public void setDesconto(BigDecimal desconto) {
        this.desconto = desconto;
        recalcularTotais();
    }

    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getDataCriacao() { return dataCriacao; }
    public void setDataCriacao(Timestamp dataCriacao) { this.dataCriacao = dataCriacao; }

    public Timestamp getDataAtualizacao() { return dataAtualizacao; }
    public void setDataAtualizacao(Timestamp dataAtualizacao) { this.dataAtualizacao = dataAtualizacao; }

    public Timestamp getDataExpiracao() { return dataExpiracao; }
    public void setDataExpiracao(Timestamp dataExpiracao) { this.dataExpiracao = dataExpiracao; }
}