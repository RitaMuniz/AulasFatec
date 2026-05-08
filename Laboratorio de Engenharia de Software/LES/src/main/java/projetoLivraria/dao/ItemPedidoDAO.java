package projetoLivraria.dao;

import projetoLivraria.model.ItemPedido;
import projetoLivraria.model.Livro;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemPedidoDAO {

    public void inserir(ItemPedido item, Connection con) throws Exception {
        String sql = """
            INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco)
            VALUES (?, ?, ?, ?)
        """;
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, item.getPedidoId());
            ps.setInt(2, item.getLivroId());
            ps.setInt(3, item.getQuantidade());
            ps.setBigDecimal(4, item.getPrecoUnitario());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) item.setId(rs.getInt(1));
            }
        }
    }

    /** Lista itens de um pedido com dados do livro. */
    public List<ItemPedido> listarPorPedido(int pedidoId) throws Exception {
        List<ItemPedido> lista = new ArrayList<>();
        String sql = """
            SELECT ip.*, l.titulo, l.autor, l.imagem_url
            FROM item_pedido ip
            JOIN livro l ON l.id = ip.livro_id
            WHERE ip.pedido_id = ?
        """;
        try (java.sql.Connection con = projetoLivraria.uteis.ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, pedidoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        }
        return lista;
    }

    /** Lista itens de um pedido usando conexão existente (para uso em transação). */
    public List<ItemPedido> listarPorPedido(int pedidoId, Connection con) throws Exception {
        List<ItemPedido> lista = new ArrayList<>();
        String sql = """
            SELECT ip.*, l.titulo, l.autor, l.imagem_url
            FROM item_pedido ip
            JOIN livro l ON l.id = ip.livro_id
            WHERE ip.pedido_id = ?
        """;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, pedidoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        }
        return lista;
    }

    public ItemPedido buscarPorId(int itemId, Connection con) throws Exception {
        String sql = """
            SELECT ip.*, l.titulo, l.autor, l.imagem_url
            FROM item_pedido ip
            JOIN livro l ON l.id = ip.livro_id
            WHERE ip.id = ?
        """;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    /** Atualiza o status de troca do item. Passa null para limpar o status. */
    public void atualizarStatusTroca(int itemId, String statusTroca, Connection con) throws Exception {
        String sql = "UPDATE item_pedido SET status_troca = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            if (statusTroca == null) ps.setNull(1, Types.VARCHAR);
            else                     ps.setString(1, statusTroca);
            ps.setInt(2, itemId);
            ps.executeUpdate();
        }
    }

    private ItemPedido mapear(ResultSet rs) throws SQLException {
        ItemPedido ip = new ItemPedido();
        ip.setId(rs.getInt("id"));
        ip.setPedidoId(rs.getInt("pedido_id"));
        ip.setLivroId(rs.getInt("livro_id"));
        ip.setQuantidade(rs.getInt("quantidade"));
        ip.setPrecoUnitario(rs.getBigDecimal("preco"));

        // subtotal calculado
        if (ip.getPrecoUnitario() != null && ip.getQuantidade() != null) {
            ip.setSubtotal(ip.getPrecoUnitario().multiply(
                    java.math.BigDecimal.valueOf(ip.getQuantidade())));
        }

        // status_troca — coluna adicionada pela migração
        try { ip.setStatusTroca(rs.getString("status_troca")); }
        catch (SQLException ignored) { /* coluna ainda não existe */ }

        // Livro resumido
        Livro l = new Livro();
        l.setId(rs.getInt("livro_id"));
        l.setTitulo(rs.getString("titulo"));
        l.setAutor(rs.getString("autor"));
        try { l.setImagemUrl(rs.getString("imagem_url")); }
        catch (SQLException ignored) {}
        ip.setLivro(l);

        return ip;
    }
}