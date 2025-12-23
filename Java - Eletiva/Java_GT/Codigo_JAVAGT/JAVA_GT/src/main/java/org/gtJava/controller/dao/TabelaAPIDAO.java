package org.gtJava.controller.dao;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.gtJava.controller.conexao.ConexaoSQL;
import org.gtJava.model.Reflorestamento;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TabelaAPIDAO {

    public List<Reflorestamento> buscarDaAPI() {
        List<Reflorestamento> lista = new ArrayList<>();
        String url = "https://api.worldbank.org/v2/country/BR/indicator/AG.LND.FRST.ZS?date=1995:2025&format=json";

        try {
            HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
            con.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String linha;
            while ((linha = br.readLine()) != null) sb.append(linha);
            br.close();

            JsonArray rootArray = JsonParser.parseString(sb.toString()).getAsJsonArray();
            JsonArray dados = rootArray.get(1).getAsJsonArray();

            for (int i = 0; i < dados.size(); i++) {
                JsonObject obj = dados.get(i).getAsJsonObject();

                int ano = obj.get("date").getAsInt();
                if (obj.get("value").isJsonNull()) continue;
                double valor = obj.get("value").getAsDouble();

                Reflorestamento r = new Reflorestamento();
                r.setAno(ano);
                r.setValorRecente(valor);
                lista.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public void sincronizarComAPI() {
        List<Reflorestamento> apiLista = buscarDaAPI();

        String sqlVerificar = "SELECT COUNT(*) FROM TabelaReflorestamento WHERE ano = ?";
        String sqlInsert = "INSERT INTO TabelaReflorestamento (ano, valorRecente) VALUES (?, ?)";
        String sqlUpdate = "UPDATE TabelaReflorestamento SET valorRecente = ? WHERE ano = ?";

        try (Connection c = ConexaoSQL.conectar()) {
            for (Reflorestamento r : apiLista) {
                try (PreparedStatement psVer = c.prepareStatement(sqlVerificar)) {
                    psVer.setInt(1, r.getAno());
                    ResultSet rs = psVer.executeQuery();
                    rs.next();
                    int count = rs.getInt(1);

                    if (count == 0) {
                        try (PreparedStatement psIns = c.prepareStatement(sqlInsert)) {
                            psIns.setInt(1, r.getAno());
                            psIns.setDouble(2, r.getValorRecente());
                            psIns.executeUpdate();
                        }
                    } else {
                        try (PreparedStatement psUpd = c.prepareStatement(sqlUpdate)) {
                            psUpd.setDouble(1, r.getValorRecente());
                            psUpd.setInt(2, r.getAno());
                            psUpd.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}