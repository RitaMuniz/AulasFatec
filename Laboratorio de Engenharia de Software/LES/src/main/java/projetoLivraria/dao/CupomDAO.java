package projetoLivraria.dao;

import projetoLivraria.model.Cupom;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class CupomDAO {

    public List<Cupom> listarDisponiveisPorCliente(int clienteId) throws Exception {
        List<Cupom> lista = new ArrayList<>();
        String sql = "SELECT * FROM cupom WHERE cliente_id = ? AND status = 'DISPONIVEL' ORDER BY tipo, valor DESC";
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

    public void marcarComoUsado(int cupomId, Connection con) throws Exception {
        String sql = "UPDATE cupom SET status = 'USADO' WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cupomId);
            ps.executeUpdate();
        }
    }

    /**
     * Cria um cupom de troca para o cliente dentro de uma transação existente.
     * Retorna o cupom criado (com id preenchido).
     *
     * @param clienteId dono do cupom
     * @param valor     valor do crédito de troca
     * @param con       conexão com transação aberta
     */
    public Cupom gerarCupomTroca(int clienteId, java.math.BigDecimal valor, Connection con) throws Exception {
        String codigo = "TROCA-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        String sql = "INSERT INTO cupom (codigo, valor, status, cliente_id, tipo) VALUES (?, ?, 'DISPONIVEL', ?, 'TROCA')";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, codigo);
            ps.setBigDecimal(2, valor);
            ps.setInt(3, clienteId);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    Cupom c = new Cupom();
                    c.setId(rs.getInt(1));
                    c.setCodigo(codigo);
                    c.setValor(valor);
                    c.setStatus(Cupom.STATUS_DISPONIVEL);
                    c.setTipo(Cupom.TIPO_TROCA);
                    c.setClienteId(clienteId);
                    return c;
                }
            }
        }
        throw new Exception("Falha ao gerar cupom de troca.");
    }

    private Cupom mapear(ResultSet rs) throws SQLException {
        Cupom c = new Cupom();
        c.setId(rs.getInt("id"));
        c.setCodigo(rs.getString("codigo"));
        c.setValor(rs.getBigDecimal("valor"));
        c.setStatus(rs.getString("status"));
        c.setClienteId(rs.getInt("cliente_id"));
        // tipo persistido no banco após a migração
        String tipo = rs.getString("tipo");
        c.setTipo(tipo != null ? tipo : Cupom.TIPO_PROMOCIONAL);
        return c;
    }
}