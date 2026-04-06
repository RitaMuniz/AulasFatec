package projetoLivraria.dao;

import projetoLivraria.uteis.ConexaoSQL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EstoqueDAO {

    public int buscarQuantidade(int livroId, Connection con) throws Exception {
        String sql = "SELECT quantidade FROM estoque WHERE livro_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, livroId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("quantidade");
            }
        }
        return 0;
    }

    public void decrementar(int livroId, int quantidade, Connection con) throws Exception {
        String sql = "UPDATE estoque SET quantidade = quantidade - ? WHERE livro_id = ? AND quantidade >= ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantidade);
            ps.setInt(2, livroId);
            ps.setInt(3, quantidade);
            int linhasAfetadas = ps.executeUpdate();
            if (linhasAfetadas == 0) {
                throw new Exception("Estoque insuficiente para o livro id " + livroId);
            }
        }
    }
}