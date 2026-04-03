package projetoLivraria.dao;

import projetoLivraria.model.Cartao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartaoDAO {

    public Cartao inserir(Connection conn, Cartao c) throws Exception {
        String sql = "INSERT INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, cvv, validade) VALUES (?,?,?,?,?,?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, c.getClienteId());
            stmt.setString(2, c.getNumero());
            stmt.setString(3, c.getNomeImpresso());
            stmt.setInt(4, c.getBandeiraId());
            stmt.setString(5, c.getCvv());
            stmt.setString(6, c.getValidade());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    c.setId(rs.getInt(1));
                }
            }
        }
        return c;
    }

    public void excluir(Connection conn, int id) throws Exception {
        String sql = "DELETE FROM cartao WHERE id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Cartao> listarPorCliente(Connection conn, int clienteId) throws Exception {
        String sql = """
            SELECT c.*, b.nome AS bandeira_nome
            FROM cartao c
            LEFT JOIN bandeira b ON c.bandeira_id = b.id
            WHERE c.cliente_id = ?
        """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clienteId);

            try (ResultSet rs = stmt.executeQuery()) {
                List<Cartao> lista = new ArrayList<>();
                while (rs.next()) {
                    lista.add(mapear(rs));
                }
                return lista;
            }
        }
    }

    private Cartao mapear(ResultSet rs) throws Exception {
        Cartao c = new Cartao();
        c.setId(rs.getInt("id"));
        c.setClienteId(rs.getInt("cliente_id"));
        c.setNumero(rs.getString("numero"));
        c.setNomeImpresso(rs.getString("nome_impresso"));
        c.setBandeiraId(rs.getInt("bandeira_id"));
        c.setBandeiraNome(rs.getString("bandeira_nome"));
        c.setCvv(rs.getString("cvv"));
        c.setValidade(rs.getString("validade"));
        return c;
    }
}