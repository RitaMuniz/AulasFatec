package projetoLivraria.dao;

import projetoLivraria.model.Cupom;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CupomDAO {

    public List<Cupom> listarDisponiveisPorCliente(int clienteId) throws Exception {
        List<Cupom> lista = new ArrayList<>();
        String sql = "SELECT * FROM cupom WHERE cliente_id = ? AND status = 'DISPONIVEL'";
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clienteId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        }
        return lista;
    }

    public Cupom buscarPorId(int id) throws Exception {
        String sql = "SELECT * FROM cupom WHERE id = ?";
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    /** Marca cupom como usado (dentro de uma transação existente) */
    public void marcarComoUsado(int cupomId, Connection con) throws Exception {
        String sql = "UPDATE cupom SET status = 'USADO' WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cupomId);
            ps.executeUpdate();
        }
    }

    private Cupom mapear(ResultSet rs) throws SQLException {
        Cupom c = new Cupom();
        c.setId(rs.getInt("id"));
        c.setCodigo(rs.getString("codigo"));
        c.setValor(rs.getBigDecimal("valor"));
        c.setStatus(rs.getString("status"));
        c.setTipo("CUPOM PROMOCIONAL");
        return c;
    }
}