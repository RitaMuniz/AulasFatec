package org.gtJava;

/*
Implementação de API para realização de CRUD, com interface interativa ao usuário

Desenvolvedoras:
Raquel
Rita de Cássia Muniz de Lima

API: WorldBank (https://databank.worldbank.org/)

*/
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import org.gtJava.controller.conexao.ConexaoAPI;
import org.gtJava.controller.conexao.ConexaoSQL;

public class Main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        Parent root = FXMLLoader.load(getClass().getResource("/view/Tela.fxml"));
        primaryStage.setTitle("Taxa de Reflorestamento no Brasil");
        primaryStage.setScene(new Scene(root, 770, 600));
        primaryStage.show();
    }
    public static void main(String[] args) {
        ConexaoAPI.conectar();
        ConexaoSQL.conectar();
        launch(args);
    }
}
