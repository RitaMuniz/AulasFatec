package projetoLivraria.dao;

import projetoLivraria.uteis.ConexaoSQL;

import java.net.URISyntaxException;
import java.sql.*;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.List;

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

        // Converte YYYY-MM-DD para milissegundos em Java (muito mais confiável que strftime no JDBC)
        Long inicioMs = null;
        Long fimMs    = null;

        if (dataInicio != null && !dataInicio.isBlank()) {
            inicioMs = LocalDate.parse(dataInicio)
                    .atStartOfDay(ZoneOffset.UTC)
                    .toInstant()
                    .toEpochMilli();
        }
        if (dataFim != null && !dataFim.isBlank()) {
            // Inclui o dia inteiro do fim: vai até 23:59:59.999
            fimMs = LocalDate.parse(dataFim)
                    .plusDays(1)
                    .atStartOfDay(ZoneOffset.UTC)
                    .toInstant()
                    .toEpochMilli() - 1;
        }

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
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
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
}