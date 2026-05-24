package projetoLivraria.dao;

import projetoLivraria.uteis.ConexaoSQL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ChatbotDAO {

    public static class LivroResumo {
        public final int id;
        public final String titulo;
        public final String autor;

        public LivroResumo(int id, String titulo, String autor) {
            this.id = id;
            this.titulo = titulo;
            this.autor = autor;
        }
    }

    /**
     * Busca livros em estoque filtrando por palavras-chave no título, autor ou categoria.
     * Se palavrasChave estiver vazio, retorna os primeiros 10 livros em estoque.
     */
    public List<LivroResumo> buscarLivrosEmEstoque(List<String> palavrasChave) {
        List<LivroResumo> resultado = new ArrayList<>();

        if (palavrasChave == null || palavrasChave.isEmpty()) {
            String sql = """
                    SELECT DISTINCT l.id, l.titulo, l.autor
                    FROM livro l
                    INNER JOIN estoque e ON e.livro_id = l.id AND e.quantidade > 0
                    WHERE l.status IS NULL OR l.status != 'inativo'
                    LIMIT 10
                    """;
            try (Connection conn = ConexaoSQL.getInstance().getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    resultado.add(new LivroResumo(
                            rs.getInt("id"),
                            rs.getString("titulo"),
                            rs.getString("autor")
                    ));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return resultado;
        }

        // Monta cláusulas LIKE para cada palavra-chave
        List<String> condicoes = new ArrayList<>();
        for (int i = 0; i < palavrasChave.size(); i++) {
            condicoes.add("LOWER(c.nome) LIKE ? OR LOWER(l.titulo) LIKE ? OR LOWER(l.autor) LIKE ?");
        }

        String sql = """
                SELECT DISTINCT l.id, l.titulo, l.autor
                FROM livro l
                INNER JOIN estoque e ON e.livro_id = l.id AND e.quantidade > 0
                LEFT JOIN livro_categoria lc ON lc.livro_id = l.id
                LEFT JOIN categoria c ON c.id = lc.categoria_id
                WHERE (l.status IS NULL OR l.status != 'inativo')
                AND (
                """ + String.join(" OR ", condicoes) + """
                )
                LIMIT 10
                """;

        try (Connection conn = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            for (String palavra : palavrasChave) {
                String like = "%" + palavra.toLowerCase() + "%";
                ps.setString(idx++, like);
                ps.setString(idx++, like);
                ps.setString(idx++, like);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    resultado.add(new LivroResumo(
                            rs.getInt("id"),
                            rs.getString("titulo"),
                            rs.getString("autor")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultado;
    }
}