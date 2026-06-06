package projetoLivraria.dao;

import projetoLivraria.model.Categoria;
import projetoLivraria.model.Livro;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.*;
import java.util.*;

public class LivroDAO {

    public List<Livro> listarTodos() throws Exception {
        String sql = """
            SELECT l.*, gp.margem_lucro,
                   e.quantidade AS estoque_qtd, e.custo AS preco_custo
            FROM livro l
            LEFT JOIN grupo_precificacao gp ON gp.id = l.grupo_precificacao_id
            LEFT JOIN estoque e ON e.livro_id = l.id
            WHERE l.status = 'ATIVO'
        """;
        return executarConsulta(sql, ps -> {});
    }

    /** Lista todos os livros sem filtrar por status (uso administrativo). */
    public List<Livro> listarAdmin() throws Exception {
        String sql = """
            SELECT l.*, gp.margem_lucro,
                   e.quantidade AS estoque_qtd, e.custo AS preco_custo
            FROM livro l
            LEFT JOIN grupo_precificacao gp ON gp.id = l.grupo_precificacao_id
            LEFT JOIN estoque e ON e.livro_id = l.id
            ORDER BY l.id
        """;
        return executarConsulta(sql, ps -> {});
    }

    /**
     * Filtra por texto livre (título/autor) e/ou categoria (id).
     * Parâmetros nulos ou vazios são ignorados.
     */
    public List<Livro> buscarComFiltros(String busca, String categoriaId) throws Exception {
        boolean temBusca     = busca != null && !busca.trim().isEmpty();
        boolean temCategoria = categoriaId != null && !categoriaId.trim().isEmpty();

        StringBuilder sql = new StringBuilder("""
            SELECT DISTINCT l.*, gp.margem_lucro,
                   e.quantidade AS estoque_qtd, e.custo AS preco_custo
            FROM livro l
            LEFT JOIN grupo_precificacao gp ON gp.id = l.grupo_precificacao_id
            LEFT JOIN estoque e ON e.livro_id = l.id
            WHERE l.status = 'ATIVO'
        """);

        if (temBusca) {
            sql.append(" AND (LOWER(l.titulo) LIKE LOWER(?) OR LOWER(l.autor) LIKE LOWER(?))");
        }
        if (temCategoria) {
            sql.append("""
                 AND l.id IN (
                     SELECT lc.livro_id FROM livro_categoria lc WHERE lc.categoria_id = ?
                 )
            """);
        }

        final boolean fb = temBusca;
        final boolean fc = temCategoria;
        final String  sb = temBusca ? busca.trim() : null;
        final String  sc = temCategoria ? categoriaId.trim() : null;

        return executarConsulta(sql.toString(), ps -> {
            int i = 1;
            if (fb) {
                ps.setString(i++, "%" + sb + "%");
                ps.setString(i++, "%" + sb + "%");
            }
            if (fc) {
                ps.setInt(i, Integer.parseInt(sc));
            }
        });
    }

    public List<Livro> listarMaisVendidos(int limite) throws Exception {
        String sql = """
            SELECT l.*, gp.margem_lucro,
                   e.quantidade AS estoque_qtd, e.custo AS preco_custo,
                   SUM(ip.quantidade) AS total_vendido
            FROM item_pedido ip
            JOIN livro l ON l.id = ip.livro_id
            LEFT JOIN grupo_precificacao gp ON gp.id = l.grupo_precificacao_id
            LEFT JOIN estoque e ON e.livro_id = l.id
            JOIN pedido p ON p.id = ip.pedido_id
            WHERE l.status = 'ATIVO'
              AND p.status NOT IN ('CANCELADO')
            GROUP BY l.id
            ORDER BY total_vendido DESC
            LIMIT ?
        """;
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limite);
            try (ResultSet rs = ps.executeQuery()) {
                List<Livro> livros = mapearLista(rs);
                carregarCategorias(con, livros);
                return livros;
            }
        }
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
                if (rs.next()) {
                    Livro livro = mapear(rs);
                    carregarCategorias(con, List.of(livro));
                    return livro;
                }
            }
        }
        return null;
    }

    /** Retorna todas as categorias cadastradas (para popular o dropdown). */
    public List<Categoria> listarCategorias() throws Exception {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT id, nome FROM categoria ORDER BY nome";
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Categoria(rs.getInt("id"), rs.getString("nome")));
            }
        }
        return lista;
    }

    @FunctionalInterface
    private interface BindParams {
        void bind(PreparedStatement ps) throws SQLException;
    }

    private List<Livro> executarConsulta(String sql, BindParams binder) throws Exception {
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            binder.bind(ps);
            try (ResultSet rs = ps.executeQuery()) {
                List<Livro> livros = mapearLista(rs);
                carregarCategorias(con, livros);
                return livros;
            }
        }
    }

    private List<Livro> mapearLista(ResultSet rs) throws SQLException {
        List<Livro> livros = new ArrayList<>();
        while (rs.next()) livros.add(mapear(rs));
        return livros;
    }

    // Carrega as categorias de todos os livros em uma única query (evita N+1).
    private void carregarCategorias(Connection con, List<Livro> livros) throws SQLException {
        if (livros.isEmpty()) return;

        Map<Integer, Livro> mapa = new LinkedHashMap<>();
        for (Livro l : livros) mapa.put(l.getId(), l);

        StringJoiner placeholders = new StringJoiner(",", "(", ")");
        livros.forEach(l -> placeholders.add("?"));

        String sql = """
            SELECT lc.livro_id, c.id AS cat_id, c.nome AS cat_nome
            FROM livro_categoria lc
            JOIN categoria c ON c.id = lc.categoria_id
            WHERE lc.livro_id IN
            """ + placeholders;

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            int i = 1;
            for (Livro l : livros) ps.setInt(i++, l.getId());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int livroId = rs.getInt("livro_id");
                    Categoria cat = new Categoria(rs.getInt("cat_id"), rs.getString("cat_nome"));
                    Livro livro = mapa.get(livroId);
                    if (livro != null) livro.getCategorias().add(cat);
                }
            }
        }
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
        l.setImagemUrl(rs.getString("imagem_url"));

        java.math.BigDecimal custo = rs.getBigDecimal("preco_custo");
        l.setPrecoCusto(custo);
        if (custo != null) {
            double margem = rs.getDouble("margem_lucro");
            java.math.BigDecimal venda = custo.multiply(
                    java.math.BigDecimal.valueOf(1 + margem / 100)
            ).setScale(2, java.math.RoundingMode.HALF_UP);
            l.setPrecoVenda(venda);
        }
        return l;
    }
}