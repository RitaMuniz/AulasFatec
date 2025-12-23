package com.example.fachada;

import com.example.dao.HospedeDAO;
import com.example.dominio.EntidadeDominio;
import com.example.model.Hospede;
import com.example.strategy.*;

import java.util.ArrayList;
import java.util.List;

public class Fachada {

    private static Fachada instance;
    private HospedeDAO hospedeDAO = new HospedeDAO();
    private List<IStrategy> validacoes = new ArrayList<>();

    private Fachada() {
        validacoes.add(new ValidarDadosObrigatorios());
        validacoes.add(new ValidarEmail());
        validacoes.add(new ValidarCPF());
    }

    public static Fachada getInstance() {
        if (instance == null) instance = new Fachada();
        return instance;
    }

    public String validar(EntidadeDominio entidade) {
        for (IStrategy s : validacoes) {
            String res = s.processar(entidade);
            if (res != null) return res;
        }
        return null;
    }

    public Hospede salvarHospede(Hospede h) throws Exception {
        String err = validar(h);
        if (err != null) throw new Exception(err);
        return hospedeDAO.salvar(h);
    }

    public Hospede alterarHospede(Hospede h) throws Exception {
        String err = validar(h);
        if (err != null) throw new Exception(err);
        return hospedeDAO.alterar(h);
    }

    public void excluirHospede(Long id) throws Exception {
        hospedeDAO.excluir(id);
    }

    public Hospede buscarHospede(Long id) throws Exception {
        return hospedeDAO.buscarPorId(id);
    }

    public List<Hospede> listarHospedes() throws Exception {
        return hospedeDAO.listarTodos();
    }

    public List<Hospede> buscarComFiltro(String nome, String cpf, String email, String telefone) throws Exception {
        return hospedeDAO.buscarComFiltro(nome, cpf, email, telefone);
    }
}
