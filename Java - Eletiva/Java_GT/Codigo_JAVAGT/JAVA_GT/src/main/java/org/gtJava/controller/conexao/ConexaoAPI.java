package org.gtJava.controller.conexao;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class ConexaoAPI {

    public static void conectar() {
        try {
            String url = "https://api.worldbank.org/v2/country/BR/indicator/AG.LND.FRST.ZS?date=1995:2025&format=json";
            HttpClient client = HttpClient.newHttpClient();

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .GET()
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            System.out.println("Resposta da API:");
            System.out.println(response.body());

        } catch (
                Exception e) {
            e.printStackTrace();
        }
    }

    public static String get(String s) {
        return null;
    }
}