package org.gtJava.controller;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import org.gtJava.controller.dao.TabelaAPIDAO;
import org.gtJava.controller.dao.TabelaReflorestamentoDAO;
import org.gtJava.model.Reflorestamento;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class TelaController {

    TabelaReflorestamentoDAO daoLocal = new TabelaReflorestamentoDAO();
    private ObservableList<Reflorestamento> lista;
    private FilteredList<Reflorestamento> listaFiltrada;

    @FXML private ComboBox<String> comboFiltro;
    @FXML private TableView<Reflorestamento> table;
    @FXML private TableColumn<Reflorestamento, Integer> colAno;
    @FXML private TableColumn<Reflorestamento, Double> colValor;
    @FXML private Button BtnEditar;
    @FXML private Button BtnExcluir;
    @FXML private Button BtnPesquisar;
    @FXML private Button BtnSalvar;
    @FXML private TextField txtAno;
    @FXML private TextField txtValor;
    @FXML private CategoryAxis xAno;
    @FXML private NumberAxis yValor;
    @FXML private javafx.scene.chart.LineChart<String, Number> grafico;

    @FXML
    public void initialize() {
        new TabelaAPIDAO().sincronizarComAPI();
        colAno.setCellValueFactory(new PropertyValueFactory<>("ano"));
        colValor.setCellValueFactory(new PropertyValueFactory<>("valorRecente"));
        atualizarTabela();

        comboFiltro.setItems(FXCollections.observableArrayList(
                "Todos",
                "Últimos 5 anos",
                "Últimos 10 anos"
        ));
        comboFiltro.getSelectionModel().selectedItemProperty().addListener((obs, oldVal, newVal) -> {
            aplicarFiltro();
            atualizarGrafico();
        });

    }

    @FXML
    private void atualizarTabela() {
        lista = FXCollections.observableArrayList(daoLocal.lista());
        FXCollections.sort(lista, Comparator.comparingInt(Reflorestamento::getAno));
        listaFiltrada = new FilteredList<>(lista, p -> true);
        table.setItems(listaFiltrada);
        aplicarFiltro();
        atualizarGrafico();
    }

    private void aplicarFiltro() {
        String filtro = comboFiltro.getSelectionModel().getSelectedItem();

        if (filtro == null || filtro.equals("Todos")) {
            listaFiltrada.setPredicate(p -> true);
            return;
        }

        int anoAtual = java.time.Year.now().getValue();

        switch (filtro) {
            case "Últimos 5 anos":
                listaFiltrada.setPredicate(r -> r.getAno() >= anoAtual - 5);
                break;

            case "Últimos 10 anos":
                listaFiltrada.setPredicate(r -> r.getAno() >= anoAtual - 10);
                break;
        }
    }

    private void atualizarGrafico() {
        grafico.getData().clear();

        XYChart.Series<String, Number> serie = new javafx.scene.chart.XYChart.Series<>();
        serie.setName("Reflorestamento por Ano");

        List<Reflorestamento> sorted = listaFiltrada.stream()
                .sorted(Comparator.comparingInt(Reflorestamento::getAno))
                .collect(Collectors.toList());

        for (Reflorestamento r : sorted) {
            serie.getData().add(new XYChart.Data<>(String.valueOf(r.getAno()), r.getValorRecente()));
        }
        grafico.getData().add(serie);
    }

    @FXML
    void btnExcluir(ActionEvent event) {
        Reflorestamento sel = table.getSelectionModel().getSelectedItem();
        if (sel == null) {
            new Alert(Alert.AlertType.WARNING, "Selecione um registro para excluir").showAndWait();
            return;
        }
        try {
            daoLocal.excluir(sel.getId());
            atualizarTabela();
            limparCampos();
        } catch (Exception e) {
            new Alert(Alert.AlertType.ERROR, "Erro ao excluir: " + e.getMessage()).showAndWait();
        }

    }

    @FXML
    void btnSalvar(ActionEvent event) {
        try {
            Reflorestamento r = new Reflorestamento();
            r.setAno(Integer.parseInt(txtAno.getText().trim()));
            r.setValorRecente(Double.parseDouble(txtValor.getText().trim()));
            daoLocal.salvar(r);
            atualizarTabela();
            limparCampos();

        } catch (Exception e) {
            new Alert(Alert.AlertType.ERROR, "Erro ao salvar: " + e.getMessage()).showAndWait();
        }
    }

    @FXML
    void btnEditar(ActionEvent event) {
        Reflorestamento sel = table.getSelectionModel().getSelectedItem();
        if (sel == null) {
            new Alert(Alert.AlertType.WARNING, "Selecione um registro para editar").showAndWait();
            return;
        }
        try {
            sel.setAno(Integer.parseInt(txtAno.getText().trim()));
            sel.setValorRecente(Double.parseDouble(txtValor.getText().trim()));
            daoLocal.editar(sel);
            atualizarTabela();
            limparCampos();
        } catch (Exception e) {
            new Alert(Alert.AlertType.ERROR, "Erro ao editar: " + e.getMessage()).showAndWait();
        }
    }

    private void limparCampos() {
        txtAno.clear();
        txtValor.clear();
    }
}