package projetoLivraria.dao;

import projetoLivraria.model.Troca;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrocaDAO {

    /** Abre solicitação de troca. Retorna o id gerado. */
    public int inserir(Troca troca, Connection con) throws Exception {
        String sql = """
            INSERT INTO troca (pedido_id, item_pedido_id, status, motivo, data_solicitacao)
            VALUES (?, ?, ?, ?, date('now'))
        """;
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, troca.getPedidoId());
            ps.setInt(2, troca.getItemPedidoId());
            ps.setString(3, Troca.STATUS_SOLICITADA);
            ps.setString(4, troca.getMotivo());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        throw new Exception("Falha ao criar solicitação de troca.");
    }

    /** Lista todas as trocas de um cliente (via pedido). */
    public List<Troca> listarPorCliente(int clienteId) throws Exception {
        List<Troca> lista = new ArrayList<>();
        String sql = """
            SELECT t.* FROM troca t
            JOIN pedido p ON p.id = t.pedido_id
            WHERE p.cliente_id = ?
            ORDER BY t.data_solicitacao DESC
        """;
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clienteId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        }
        return lista;
    }

    /** Lista todas as trocas (admin). */
    public List<Troca> listarTodas() throws Exception {
        List<Troca> lista = new ArrayList<>();
        String sql = "SELECT * FROM troca ORDER BY data_solicitacao DESC";
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        }
        return lista;
    }

    public Troca buscarPorId(int id) throws Exception {
        String sql = "SELECT * FROM troca WHERE id = ?";
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    /** Busca troca por id usando conexão existente (para uso em transação). */
    public Troca buscarPorId(int id, Connection con) throws Exception {
        String sql = "SELECT * FROM troca WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    /** Atualiza status (admin). */
    public void atualizarStatus(int trocaId, String status, Connection con) throws Exception {
        String sql = "UPDATE troca SET status = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, trocaId);
            ps.executeUpdate();
        }
    }

    /** Registra data de recebimento e cupom gerado ao concluir a troca. */
    public void concluir(int trocaId, int cupomGeradoId, Connection con) throws Exception {
        String sql = """
            UPDATE troca
            SET status = 'CONCLUIDA', data_recebimento = date('now'), cupom_gerado_id = ?
            WHERE id = ?
        """;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cupomGeradoId);
            ps.setInt(2, trocaId);
            ps.executeUpdate();
        }
    }

    private Troca mapear(ResultSet rs) throws SQLException {
        Troca t = new Troca();
        t.setId(rs.getInt("id"));
        t.setPedidoId(rs.getInt("pedido_id"));

        int itemId = rs.getInt("item_pedido_id");
        if (!rs.wasNull()) t.setItemPedidoId(itemId);

        t.setStatus(rs.getString("status"));
        t.setMotivo(rs.getString("motivo"));

        String dsStr = rs.getString("data_solicitacao");
        if (dsStr != null) {
            t.setDataSolicitacao(java.sql.Date.valueOf(dsStr));
        }

        String drStr = rs.getString("data_recebimento");
        if (drStr != null) {
            t.setDataRecebimento(java.sql.Date.valueOf(drStr));
        }

        int cupomId = rs.getInt("cupom_gerado_id");
        if (!rs.wasNull()) t.setCupomGeradoId(cupomId);

        return t;
    }
}