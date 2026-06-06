package projetoLivraria.service;

import projetoLivraria.dao.LogDAO;

public class LogService {

    private final LogDAO logDAO = new LogDAO();
    private final String usuario;

    public LogService(String usuario) {
        this.usuario = usuario;
    }

    public void registrarInsercao(String tabela, String dadosNovos) {
        logDAO.registrar(usuario, "INSERÇÃO", tabela, null, dadosNovos);
    }

    public void registrarAlteracao(String tabela, String dadosAnteriores, String dadosNovos) {
        logDAO.registrar(usuario, "ALTERAÇÃO", tabela, dadosAnteriores, dadosNovos);
    }

    public void registrarExclusao(String tabela, String dadosAnteriores) {
        logDAO.registrar(usuario, "EXCLUSÃO", tabela, dadosAnteriores, null);
    }

    // Genérico para ações que não se encaixam nas três anteriores
    public void registrar(String acao, String tabela, String dadosAnteriores, String dadosNovos) {
        logDAO.registrar(usuario, acao, tabela, dadosAnteriores, dadosNovos);
    }
}