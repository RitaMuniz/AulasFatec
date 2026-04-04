package projetoLivraria.dao;

import projetoLivraria.model.Pedido;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    public List<Pedido> listarPorCliente(int clienteId) throws Exception {
        List<Pedido> lista = new ArrayList<>();
        String sql = "SELECT * FROM pedido WHERE cliente_id = ? ORDER BY data DESC";
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clienteId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        }
        return lista;
    }

    public Pedido buscarPorId(int pedidoId, int clienteId) throws Exception {
        String sql = "SELECT * FROM pedido WHERE id = ? AND cliente_id = ?";
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, pedidoId);
            ps.setInt(2, clienteId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    private Pedido mapear(ResultSet rs) throws SQLException {
        Pedido p = new Pedido();
        p.setId(rs.getInt("id"));
        p.setClienteId(rs.getInt("cliente_id"));
        p.setEnderecoEntregaId(rs.getInt("endereco_entrega_id"));
        p.setStatus(rs.getString("status"));
        p.setTotal(rs.getBigDecimal("valor_total"));
        p.setDataCriacao(rs.getTimestamp("data"));
        return p;
    }
}