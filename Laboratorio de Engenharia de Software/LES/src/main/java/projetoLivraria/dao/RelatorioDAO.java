package projetoLivraria.dao;

import projetoLivraria.uteis.ConexaoSQL;

import java.sql.*;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.*;

public class RelatorioDAO {

    public List<VendaCategoriaMes> buscarVendasPorCategoriaMes(String dataInicio, String dataFim)
            throws SQLException {

        StringBuilder sql = new StringBuilder("""
            SELECT
                strftime('%Y-%m', datetime(p.data / 1000, 'unixepoch')) AS mes,
                c.nome                                                   AS categoria,
                SUM(ip.quantidade)                                       AS total
            FROM pedido          p
            JOIN item_pedido     ip ON ip.pedido_id  = p.id
            JOIN livro           l  ON l.id           = ip.livro_id
            JOIN livro_categoria lc ON lc.livro_id    = l.id
            JOIN categoria       c  ON c.id           = lc.categoria_id
            """);

        Long inicioMs = toInicioMs(dataInicio);
        Long fimMs = toFimMs(dataFim);

        List<String> condicoes = new ArrayList<>();
        if (inicioMs != null) condicoes.add("p.data >= ?");
        if (fimMs    != null) condicoes.add("p.data <= ?");

        if (!condicoes.isEmpty())
            sql.append("WHERE ").append(String.join(" AND ", condicoes)).append("\n");

        sql.append("""
            GROUP BY mes, c.id, c.nome
            ORDER BY mes, c.nome
            """);

        List<VendaCategoriaMes> resultado = new ArrayList<>();

        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (inicioMs != null) ps.setLong(idx++, inicioMs);
            if (fimMs    != null) ps.setLong(idx,   fimMs);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    resultado.add(new VendaCategoriaMes(
                            rs.getString("mes"),
                            rs.getString("categoria"),
                            rs.getInt("total")
                    ));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return resultado;
    }

    public static class VendaCategoriaMes {
        public final String mes;
        public final String categoria;
        public final int    total;

        public VendaCategoriaMes(String mes, String categoria, int total) {
            this.mes       = mes;
            this.categoria = categoria;
            this.total     = total;
        }
    }

    /** Faturamento total de pedidos não cancelados no período. */
    public double getFaturamentoTotal(String dataInicial, String dataFinal) throws Exception {
        StringBuilder sql = new StringBuilder(
                "SELECT COALESCE(SUM(valor_total), 0) FROM pedido WHERE LOWER(status) != 'cancelado'"
        );
        Long inicioMs = toInicioMs(dataInicial);
        Long fimMs    = toFimMs(dataFinal);
        if (inicioMs != null) sql.append(" AND data >= ?");
        if (fimMs    != null) sql.append(" AND data <= ?");

        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            if (inicioMs != null) ps.setLong(idx++, inicioMs);
            if (fimMs    != null) ps.setLong(idx,   fimMs);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getDouble(1) : 0.0;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /** Total de pedidos no período. */
    public int getTotalPedidos(String dataInicial, String dataFinal) throws Exception {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM pedido WHERE 1=1");
        Long inicioMs = toInicioMs(dataInicial);
        Long fimMs    = toFimMs(dataFinal);
        if (inicioMs != null) sql.append(" AND data >= ?");
        if (fimMs    != null) sql.append(" AND data <= ?");

        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            if (inicioMs != null) ps.setLong(idx++, inicioMs);
            if (fimMs    != null) ps.setLong(idx,   fimMs);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /** Clientes com status ATIVO (sem filtro de período). */
    public int getClientesAtivos() throws Exception {
        String sql = "SELECT COUNT(*) FROM cliente WHERE UPPER(status) = 'ATIVO'";
        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /** Título do livro mais vendido (por quantidade) no período. */
    public String getLivroMaisVendido(String dataInicial, String dataFinal) throws Exception {
        StringBuilder sql = new StringBuilder(
                "SELECT l.titulo, SUM(ip.quantidade) AS total " +
                        "FROM item_pedido ip " +
                        "JOIN livro l ON l.id = ip.livro_id " +
                        "JOIN pedido p ON p.id = ip.pedido_id " +
                        "WHERE LOWER(p.status) != 'cancelado'"
        );
        Long inicioMs = toInicioMs(dataInicial);
        Long fimMs    = toFimMs(dataFinal);
        if (inicioMs != null) sql.append(" AND p.data >= ?");
        if (fimMs    != null) sql.append(" AND p.data <= ?");
        sql.append(" GROUP BY l.id, l.titulo ORDER BY total DESC LIMIT 1");

        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            if (inicioMs != null) ps.setLong(idx++, inicioMs);
            if (fimMs    != null) ps.setLong(idx,   fimMs);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getString("titulo") : "-";
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Histórico de vendas para a tabela da página de relatórios.
     * A data é convertida de ms → string legível (YYYY-MM-DD) via strftime.
     */
    public List<Map<String, Object>> getHistoricoVendas(String dataInicial, String dataFinal)
            throws Exception {

        StringBuilder sql = new StringBuilder(
                "SELECT p.id, c.nome AS cliente, " +
                        "strftime('%Y-%m-%d', datetime(p.data / 1000, 'unixepoch')) AS data_formatada, " +
                        "p.valor_total, p.status " +
                        "FROM pedido p " +
                        "JOIN cliente c ON c.id = p.cliente_id " +
                        "WHERE 1=1"
        );
        Long inicioMs = toInicioMs(dataInicial);
        Long fimMs    = toFimMs(dataFinal);
        if (inicioMs != null) sql.append(" AND p.data >= ?");
        if (fimMs    != null) sql.append(" AND p.data <= ?");
        sql.append(" ORDER BY p.data DESC");

        try (Connection con = ConexaoSQL.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            if (inicioMs != null) ps.setLong(idx++, inicioMs);
            if (fimMs    != null) ps.setLong(idx,   fimMs);
            try (ResultSet rs = ps.executeQuery()) {
                List<Map<String, Object>> lista = new ArrayList<>();
                while (rs.next()) {
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("id",          rs.getInt("id"));
                    row.put("cliente",     rs.getString("cliente"));
                    row.put("dataPedido",  rs.getString("data_formatada")); // YYYY-MM-DD
                    row.put("valorTotal",  rs.getDouble("valor_total"));
                    row.put("status",      rs.getString("status"));
                    lista.add(row);
                }
                return lista;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // Helpers de conversão de data
    /** "YYYY-MM-DD" → milissegundos UTC do início do dia (00:00:00.000). */
    private Long toInicioMs(String data) {
        if (data == null || data.isBlank()) return null;
        return LocalDate.parse(data)
                .atStartOfDay(ZoneOffset.UTC)
                .toInstant()
                .toEpochMilli();
    }

    /** "YYYY-MM-DD" → milissegundos UTC do fim do dia (23:59:59.999). */
    private Long toFimMs(String data) {
        if (data == null || data.isBlank()) return null;
        return LocalDate.parse(data)
                .plusDays(1)
                .atStartOfDay(ZoneOffset.UTC)
                .toInstant()
                .toEpochMilli() - 1;
    }
}