package projetoLivraria.dao;

import projetoLivraria.model.ItemPedido;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
}