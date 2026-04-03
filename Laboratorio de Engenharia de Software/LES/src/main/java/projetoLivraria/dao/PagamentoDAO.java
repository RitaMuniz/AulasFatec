package projetoLivraria.dao;

import projetoLivraria.model.Pagamento;

import java.sql.*;

public class PagamentoDAO {

    public void inserir(Pagamento pagamento, Connection con) throws SQLException {
        String sql = """
        INSERT INTO pagamento (pedido_id, cartao_id, cupom_id, valor)
        VALUES (?, ?, ?, ?)
    """;

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, pagamento.getPedidoId());

            if (pagamento.getCartaoId() != null)
                stmt.setInt(2, pagamento.getCartaoId());
            else
                stmt.setNull(2, Types.INTEGER);

            if (pagamento.getCodigoCupom() != null)
                stmt.setInt(3, Integer.parseInt(pagamento.getCodigoCupom()));
            else
                stmt.setNull(3, Types.INTEGER);

            stmt.setBigDecimal(4, pagamento.getValor());

            stmt.executeUpdate();
        }
    }
}