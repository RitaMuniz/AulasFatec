package projetoLivraria.dao;

import projetoLivraria.model.Livro;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LivroDAO {

    public List<Livro> listarTodos() throws Exception {
        List<Livro> livros = new ArrayList<>();
        String sql = """
            SELECT l.*, gp.margem_lucro,
                   e.quantidade AS estoque_qtd, e.custo AS preco_custo
            FROM livro l
            LEFT JOIN grupo_precificacao gp ON gp.id = l.grupo_precificacao_id
            LEFT JOIN estoque e ON e.livro_id = l.id
            WHERE l.status = 'ATIVO'
        """;
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) livros.add(mapear(rs));
        }
        return livros;
    }

    public Livro buscarPorId(int id) throws Exception {
        String sql = """
            SELECT l.*, gp.margem_lucro,
                   e.quantidade AS estoque_qtd, e.custo AS preco_custo
            FROM livro l
            LEFT JOIN grupo_precificacao gp ON gp.id = l.grupo_precificacao_id
            LEFT JOIN estoque e ON e.livro_id = l.id
            WHERE l.id = ?
        """;
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    private Livro mapear(ResultSet rs) throws SQLException {
        Livro l = new Livro();
        l.setId(rs.getInt("id"));
        l.setTitulo(rs.getString("titulo"));
        l.setAutor(rs.getString("autor"));
        l.setEditora(rs.getString("editora"));
        l.setIsbn(rs.getString("isbn"));
        l.setAno(rs.getObject("ano") != null ? rs.getInt("ano") : null);
        l.setNumeroPaginas(rs.getObject("paginas") != null ? rs.getInt("paginas") : null);
        l.setSinopse(rs.getString("sinopse"));
        l.setCodigoBarras(rs.getString("codigo_barras"));
        l.setStatus(rs.getString("status"));
        l.setEstoque(rs.getObject("estoque_qtd") != null ? rs.getInt("estoque_qtd") : 0);

        java.math.BigDecimal custo = rs.getBigDecimal("preco_custo");
        l.setPrecoCusto(custo);
        if (custo != null) {
            double margem = rs.getDouble("margem_lucro");
            java.math.BigDecimal venda = custo.multiply(
                    java.math.BigDecimal.valueOf(1 + margem)
            ).setScale(2, java.math.RoundingMode.HALF_UP);
            l.setPrecoVenda(venda);
        }
        return l;
    }
}