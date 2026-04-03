package projetoLivraria.dao;

import projetoLivraria.model.Pedido;

import java.sql.*;

public class PedidoDAO {

    public int inserir(Pedido pedido, Connection con) throws Exception {

        String sql = "INSERT INTO pedido (cliente_id, endereco_entrega_id, data, valor_total, status) VALUES (?, ?, ?, ?, ?)";

        PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        stmt.setInt(1, pedido.getClienteId());
        stmt.setInt(2, pedido.getEnderecoEntregaId());
        stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
        stmt.setDouble(4, pedido.getTotal().doubleValue());
        stmt.setString(5, pedido.getStatus());

        stmt.executeUpdate();

        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) return rs.getInt(1);

        throw new Exception("Erro ao criar pedido");
    }
}
