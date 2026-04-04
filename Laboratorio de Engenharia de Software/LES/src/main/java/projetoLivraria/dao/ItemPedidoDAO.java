package projetoLivraria.dao;

import projetoLivraria.model.ItemPedido;
import projetoLivraria.model.Livro;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemPedidoDAO {

    public void inserir(ItemPedido item, Connection con) throws Exception {

        String sql = "INSERT INTO item_pedido (pedido_id, livro_id, quantidade, preco) VALUES (?, ?, ?, ?)";

        PreparedStatement stmt = con.prepareStatement(sql);

        stmt.setInt(1, item.getPedidoId());
        stmt.setInt(2, item.getLivroId());
        stmt.setInt(3, item.getQuantidade());
        stmt.setBigDecimal(4, item.getPrecoUnitario());

        stmt.executeUpdate();
    }

    public List<ItemPedido> listarPorPedido(int pedidoId) throws Exception {
        List<ItemPedido> lista = new ArrayList<>();
        String sql = """
            SELECT ip.*, l.titulo, l.autor
            FROM item_pedido ip
            JOIN livro l ON l.id = ip.livro_id
            WHERE ip.pedido_id = ?
        """;
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, pedidoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ItemPedido ip = new ItemPedido();
                    ip.setId(rs.getInt("id"));
                    ip.setPedidoId(pedidoId);
                    ip.setLivroId(rs.getInt("livro_id"));
                    ip.setQuantidade(rs.getInt("quantidade"));
                    ip.setPrecoUnitario(rs.getBigDecimal("preco"));
                    ip.setSubtotal(rs.getBigDecimal("preco").multiply(
                            java.math.BigDecimal.valueOf(rs.getInt("quantidade"))
                    ));

                    Livro l = new Livro();
                    l.setId(rs.getInt("livro_id"));
                    l.setTitulo(rs.getString("titulo"));
                    l.setAutor(rs.getString("autor"));
                    ip.setLivro(l);

                    lista.add(ip);
                }
            }
        }
        return lista;
    }
}