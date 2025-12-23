package org.gtPoo.controller;

import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.gtPoo.controller.dao.EmprestimoDAO;
import org.gtPoo.controller.dao.LivroDAO;
import org.gtPoo.controller.dao.UsuarioDAO;
import org.gtPoo.model.*;

import java.time.LocalDate;
import java.util.List;

public class TelaPrincipalController {

    @FXML private ComboBox<String> boxFiltroLivro;
    @FXML private ChoiceBox<String> boxFiltroUsuario;

    @FXML private Button btnExcluirEmprestimo;
    @FXML private Button btnExcluirLivro;
    @FXML private Button btnExcluirUsuario;
    @FXML private Button btnSalvarEmprestimo;
    @FXML private Button btnSalvarLivro;
    @FXML private Button btnSalvarUsuario;

    @FXML private CheckBox cbEbook;
    @FXML private CheckBox cbFisico;

    @FXML private DatePicker dataFim;
    @FXML private DatePicker datanicio;

    @FXML private ChoiceBox<Livro> livro;
    @FXML private ChoiceBox<String> statususuario;
    @FXML private ChoiceBox<Usuario> usuario;

    @FXML private TableView<Emprestimo> tabelaEmprestimo;
    @FXML private TableView<Livro> tabelaLivro;
    @FXML private TableView<Usuario> tabelaUsuario;

    @FXML private TableColumn<Emprestimo, String> colunaEmprestimoDevolucao;
    @FXML private TableColumn<Emprestimo, String> colunaEmprestimoLivro;
    @FXML private TableColumn<Emprestimo, String> colunaEmprestimoMulta;
    @FXML private TableColumn<Emprestimo, String> colunaEmprestimoRetirada;
    @FXML private TableColumn<Emprestimo, String> colunaEmprestimoUsuario;

    @FXML private TableColumn<Livro, String> colunaLivroAutor;
    @FXML private TableColumn<Livro, String> colunaLivroIsbn;
    @FXML private TableColumn<Livro, String> colunaLivroTipo;
    @FXML private TableColumn<Livro, String> colunaLivroTitilo;

    @FXML private TableColumn<Usuario, String> colunaUsuarioEmail;
    @FXML private TableColumn<Usuario, String> colunaUsuarioNome;
    @FXML private TableColumn<Usuario, String> colunaUsuarioRegistro;
    @FXML private TableColumn<Usuario, String> colunaUsuarioTelefone;
    @FXML private TableColumn<Usuario, String> colunaUsuarioTipo;

    @FXML private TextField txtAutor;
    @FXML private TextField txtEmail;
    @FXML private TextField txtISBN;
    @FXML private TextField txtNRegistro;
    @FXML private TextField txtNome;
    @FXML private TextField txtTelefone;
    @FXML private TextField txtTitulo;

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();
    private final LivroDAO livroDAO = new LivroDAO();
    private final EmprestimoDAO emprestimoDAO = new EmprestimoDAO();

    @FXML
    public void initialize() {

        statususuario.getItems().addAll("Aluno", "Professor");
        boxFiltroUsuario.getItems().addAll("Todos", "Aluno", "Professor");
        boxFiltroLivro.getItems().addAll("Todos", "Físico", "Ebook");

        boxFiltroLivro.setValue("Todos");
        boxFiltroUsuario.setValue("Todos");

        //tabela usuários
        colunaUsuarioNome.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getNome()));
        colunaUsuarioEmail.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getEmail()));
        colunaUsuarioTelefone.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getTelefone()));
        colunaUsuarioRegistro.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getNumeroRegistro()));
        colunaUsuarioTipo.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getTipo()));

        //tabela livros
        colunaLivroTitilo.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getTitulo()));
        colunaLivroIsbn.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getIsbn()));
        colunaLivroAutor.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getAutor()));

        colunaLivroTipo.setCellValueFactory(c -> {
            Livro l = c.getValue();
            return new SimpleStringProperty(l instanceof Fisico ? "Físico" : "Ebook");
        });

        //tabela empréstimo
        colunaEmprestimoLivro.setCellValueFactory(c -> {
            Livro l = c.getValue().getLivro();
            return new SimpleStringProperty(l != null ? l.getTitulo() : "");
        });

        colunaEmprestimoUsuario.setCellValueFactory(c -> {
            Usuario u = c.getValue().getUsuario();
            return new SimpleStringProperty(u != null ? u.getNome() : "");
        });

        colunaEmprestimoRetirada.setCellValueFactory(c ->
                new SimpleStringProperty(c.getValue().getDataRetirada().toString()));

        colunaEmprestimoDevolucao.setCellValueFactory(c ->
                new SimpleStringProperty(c.getValue().getDataDevolucao().toString()));

        colunaEmprestimoMulta.setCellValueFactory(c -> {
            Emprestimo e = c.getValue();
            int dias = e.diasAtraso();
            double multa = 0;

            if (e.getLivro() != null && dias > 0) {
                multa = e.getLivro().calcularMulta(dias);
            }

            return new SimpleStringProperty(String.format("R$ %.2f", multa));
        });

        carregarUsuarios();
        carregarLivros();
        carregarEmprestimos();

        boxFiltroUsuario.setOnAction(e -> filtrarUsuarios());
        boxFiltroLivro.setOnAction(e -> filtrarLivros());

        btnSalvarUsuario.setOnAction(e -> salvarUsuario());
        btnExcluirUsuario.setOnAction(e -> excluirUsuario());

        btnSalvarLivro.setOnAction(e -> salvarLivro());
        btnExcluirLivro.setOnAction(e -> excluirLivro());

        btnSalvarEmprestimo.setOnAction(e -> salvarEmprestimo());
        btnExcluirEmprestimo.setOnAction(e -> excluirEmprestimo());
    }

    //Usuario

    private void carregarUsuarios() {
        List<Usuario> usuarios = usuarioDAO.listarTodos();
        tabelaUsuario.getItems().setAll(usuarios);
        usuario.getItems().setAll(usuarios);
    }

    private void filtrarUsuarios() {
        String f = boxFiltroUsuario.getValue();
        if (f.equals("Todos")) {
            carregarUsuarios();
            return;
        }

        tabelaUsuario.getItems().setAll(
                usuarioDAO.listarTodos().stream()
                        .filter(u -> u.getTipo().equalsIgnoreCase(f))
                        .toList()
        );
    }

    private void salvarUsuario() {
        if (txtNome.getText().isEmpty()) {
            alertaErro("Nome é obrigatório");
            return;
        }

        Usuario u = new Usuario(
                txtNome.getText(),
                txtEmail.getText(),
                txtTelefone.getText(),
                txtNRegistro.getText(),
                statususuario.getValue()
        );

        usuarioDAO.salvar(u);
        carregarUsuarios();
        limparCamposUsuario();
    }

    private void excluirUsuario() {
        Usuario sel = tabelaUsuario.getSelectionModel().getSelectedItem();
        if (sel == null) {
            alertaErro("Selecione um usuário");
            return;
        }

        if (!confirmar("Excluir usuário " + sel.getNome() + "?")) return;

        usuarioDAO.excluir(sel);
        carregarUsuarios();
    }

    private void limparCamposUsuario() {
        txtNome.clear();
        txtEmail.clear();
        txtTelefone.clear();
        txtNRegistro.clear();
    }

    //Livro

    private void carregarLivros() {
        List<Livro> livros = livroDAO.listarTodos();
        tabelaLivro.getItems().setAll(livros);
        livro.getItems().setAll(livros);
    }

    private void filtrarLivros() {
        String f = boxFiltroLivro.getValue();

        if (f.equals("Todos")) {
            carregarLivros();
            return;
        }

        boolean fisico = f.equals("Físico");

        tabelaLivro.getItems().setAll(
                livroDAO.listarTodos().stream()
                        .filter(l -> fisico ? l instanceof Fisico : l instanceof Ebook)
                        .toList()
        );
    }

    private void salvarLivro() {
        if (txtTitulo.getText().isEmpty()) {
            alertaErro("Título é obrigatório");
            return;
        }

        Livro novo;

        if (cbFisico.isSelected() && !cbEbook.isSelected()) {
            novo = new Fisico(txtTitulo.getText(), txtISBN.getText(), txtAutor.getText());
        } else if (cbEbook.isSelected() && !cbFisico.isSelected()) {
            novo = new Ebook(txtTitulo.getText(), txtISBN.getText(), txtAutor.getText());
        } else {
            alertaErro("Selecione APENAS um tipo: físico OU ebook");
            return;
        }

        livroDAO.salvar(novo);
        carregarLivros();
        limparCamposLivro();
    }

    private void excluirLivro() {
        Livro sel = tabelaLivro.getSelectionModel().getSelectedItem();
        if (sel == null) {
            alertaErro("Selecione um livro");
            return;
        }

        if (!confirmar("Excluir livro " + sel.getTitulo() + "?")) return;

        livroDAO.excluir(sel);
        carregarLivros();
    }

    private void limparCamposLivro() {
        txtTitulo.clear();
        txtISBN.clear();
        txtAutor.clear();
        cbFisico.setSelected(false);
        cbEbook.setSelected(false);
    }

    //Emprestimo

    private void carregarEmprestimos() {
        tabelaEmprestimo.getItems().setAll(emprestimoDAO.listarTodos());
    }

    private void salvarEmprestimo() {
        Usuario u = usuario.getValue();
        Livro l = livro.getValue();
        LocalDate dr = datanicio.getValue();
        LocalDate dd = dataFim.getValue();

        if (u == null || l == null) { alertaErro("Selecione usuário e livro"); return; }
        if (dr == null || dd == null) { alertaErro("Selecione datas"); return; }
        if (dd.isBefore(dr)) { alertaErro("Data inválida"); return; }

        Emprestimo e = new Emprestimo();
        e.setUsuario(u);
        e.setLivro(l);
        e.setDataRetirada(dr);
        e.setDataDevolucao(dd);

        emprestimoDAO.salvar(e);
        carregarEmprestimos();
        limparCamposEmprestimo();
    }

    private void excluirEmprestimo() {
        Emprestimo sel = tabelaEmprestimo.getSelectionModel().getSelectedItem();
        if (sel == null) {
            alertaErro("Selecione um empréstimo");
            return;
        }

        if (!confirmar("Excluir empréstimo?")) return;

        emprestimoDAO.excluir(sel);
        carregarEmprestimos();
    }

    private void limparCamposEmprestimo() {
        datanicio.setValue(null);
        dataFim.setValue(null);
    }

    private void alertaErro(String msg) {
        new Alert(Alert.AlertType.ERROR, msg).showAndWait();
    }

    private boolean confirmar(String msg) {
        Alert a = new Alert(Alert.AlertType.CONFIRMATION, msg, ButtonType.YES, ButtonType.NO);
        return a.showAndWait().orElse(ButtonType.NO) == ButtonType.YES;
    }
}
