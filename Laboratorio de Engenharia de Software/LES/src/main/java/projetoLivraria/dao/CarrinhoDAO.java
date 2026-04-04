package projetoLivraria.dao;

import projetoLivraria.model.Carrinho;
import projetoLivraria.model.ItemCarrinho;
import projetoLivraria.uteis.ConexaoSQL;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarrinhoDAO {

    /** Busca o carrinho ativo do cliente, com itens carregados */
    public Carrinho buscarAtivoporCliente(int clienteId) throws SQLException {
        String sql = "SELECT * FROM Carrinho WHERE cliente_id = ? AND status = 'ATIVO' LIMIT 1";
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clienteId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Carrinho c = mapear(rs);
                    c.setItens(listarItens(c.getId(), con));
                    return c;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    /** Cria um novo carrinho para o cliente e retorna o id gerado */
    public int inserir(int clienteId, Connection con) throws SQLException {
        String sql = """
            INSERT INTO Carrinho (cliente_id, subtotal, frete, desconto, total, status, data_criacao, data_atualizacao)
            VALUES (?, 0, 0, 0, 0, 'ATIVO', datetime('now'), datetime('now'))
        """;
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, clienteId);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        throw new SQLException("Falha ao criar carrinho.");
    }

    /** Atualiza totais do carrinho */
    public void atualizarTotais(Carrinho carrinho, Connection con) throws SQLException {
        String sql = """
            UPDATE Carrinho SET subtotal=?, frete=?, desconto=?, total=?, data_atualizacao=datetime('now')
            WHERE id=?
        """;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBigDecimal(1, carrinho.getSubtotal());
            ps.setBigDecimal(2, carrinho.getFrete());
            ps.setBigDecimal(3, carrinho.getDesconto());
            ps.setBigDecimal(4, carrinho.getTotal());
            ps.setInt(5, carrinho.getId());
            ps.executeUpdate();
        }
    }

    /** Muda status do carrinho (ex: ATIVO → FINALIZADO) */
    public void atualizarStatus(int carrinhoId, String status, Connection con) throws SQLException {
        String sql = "UPDATE Carrinho SET status=?, data_atualizacao=datetime('now') WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, carrinhoId);
            ps.executeUpdate();
        }
    }

    public void inserirItem(ItemCarrinho item, Connection con) throws SQLException {
        String sql = """
            INSERT INTO Item_carrinho (carrinho_id, livro_id, quantidade, preco_unitario, subtotal, status)
            VALUES (?, ?, ?, ?, ?, 'ATIVO')
        """;
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, item.getCarrinhoId());
            ps.setInt(2, item.getLivroId());
            ps.setInt(3, item.getQuantidade());
            ps.setBigDecimal(4, item.getPrecoUnitario());
            ps.setBigDecimal(5, item.getSubtotal());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) item.setId(rs.getInt(1));
            }
        }
    }

    public void atualizarItemQuantidade(int itemId, int quantidade, BigDecimal subtotal, Connection con)
            throws SQLException {
        String sql = "UPDATE Item_carrinho SET quantidade=?, subtotal=? WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantidade);
            ps.setBigDecimal(2, subtotal);
            ps.setInt(3, itemId);
            ps.executeUpdate();
        }
    }

    public void removerItem(int itemId, Connection con) throws SQLException {
        String sql = "DELETE FROM Item_carrinho WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            ps.executeUpdate();
        }
    }

    public void removerTodosItens(int carrinhoId, Connection con) throws SQLException {
        String sql = "DELETE FROM Item_carrinho WHERE carrinho_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, carrinhoId);
            ps.executeUpdate();
        }
    }

    private List<ItemCarrinho> listarItens(int carrinhoId, Connection con) throws SQLException {
        List<ItemCarrinho> itens = new ArrayList<>();
        String sql = """
            SELECT ic.*, l.titulo, l.autor FROM Item_carrinho ic
            JOIN Livro l ON l.id = ic.livro_id
            WHERE ic.carrinho_id = ? AND ic.status = 'ATIVO'
        """;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, carrinhoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) itens.add(mapearItem(rs, carrinhoId));
            }
        }
        return itens;
    }

    private Carrinho mapear(ResultSet rs) throws SQLException {
        Carrinho c = new Carrinho();
        c.setId(rs.getInt("id"));
        c.setClienteId(rs.getInt("cliente_id"));
        c.setSubtotal(rs.getBigDecimal("subtotal"));
        c.setFrete(rs.getBigDecimal("frete"));
        c.setDesconto(rs.getBigDecimal("desconto"));
        c.setTotal(rs.getBigDecimal("total"));
        c.setStatus(rs.getString("status"));
        c.setDataCriacao(rs.getTimestamp("data_criacao"));
        c.setDataAtualizacao(rs.getTimestamp("data_atualizacao"));
        return c;
    }

    private ItemCarrinho mapearItem(ResultSet rs, int carrinhoId) throws SQLException {
        ItemCarrinho ic = new ItemCarrinho();
        ic.setId(rs.getInt("id"));
        ic.setCarrinhoId(carrinhoId);
        ic.setLivroId(rs.getInt("livro_id"));
        ic.setQuantidade(rs.getInt("quantidade"));
        ic.setPrecoUnitario(rs.getBigDecimal("preco_unitario"));
        ic.setSubtotal(rs.getBigDecimal("subtotal"));
        ic.setStatus(rs.getString("status"));

        // Livro resumido para exibição
        projetoLivraria.model.Livro l = new projetoLivraria.model.Livro();
        l.setId(rs.getInt("livro_id"));
        l.setTitulo(rs.getString("titulo"));
        l.setAutor(rs.getString("autor"));
        l.setPrecoVenda(rs.getBigDecimal("preco_unitario"));
        ic.setLivro(l);

        return ic;
    }
}