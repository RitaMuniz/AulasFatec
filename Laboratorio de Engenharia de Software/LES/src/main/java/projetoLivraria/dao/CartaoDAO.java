package projetoLivraria.dao;

import projetoLivraria.model.Cartao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartaoDAO {

    public Cartao inserir(Connection conn, Cartao c) throws Exception {
        String sql = "INSERT INTO cartao (cliente_id, numero, nome_impresso, bandeira_id, validade, cvv) VALUES (?,?,?,?,?,?)";

        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setInt(1, c.getClienteId());
        stmt.setString(2, c.getNumero());
        stmt.setString(3, c.getNomeImpresso());
        stmt.setInt(4, c.getBandeiraId());
        stmt.setString(5, c.getValidade());
        stmt.setString(6, c.getCvv());

        stmt.executeUpdate();

        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            c.setId(rs.getInt(1));
        }
        return c;
    }

    public void excluir(Connection conn, int id) throws Exception {
        String sql = "DELETE FROM cartao WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    // JOIN com bandeira para trazer o nome junto
    public List<Cartao> listarPorCliente(Connection conn, int clienteId) throws Exception {
        String sql = """
            SELECT c.*, b.nome AS bandeira_nome
            FROM cartao c
            LEFT JOIN bandeira b ON c.bandeira_id = b.id
            WHERE c.cliente_id = ?
        """;

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, clienteId);

        ResultSet rs = stmt.executeQuery();
        List<Cartao> lista = new ArrayList<>();
        while (rs.next()) {
            lista.add(mapear(rs));
        }
        return lista;
    }

    private Cartao mapear(ResultSet rs) throws Exception {
        Cartao c = new Cartao();
        c.setId(rs.getInt("id"));
        c.setClienteId(rs.getInt("cliente_id"));
        c.setNumero(rs.getString("numero"));
        c.setNomeImpresso(rs.getString("nome_impresso"));
        c.setBandeiraId(rs.getInt("bandeira_id"));
        c.setBandeiraNome(rs.getString("bandeira_nome"));
        c.setValidade(rs.getString("validade"));
        c.setCvv(rs.getString("cvv"));
        return c;
    }
}