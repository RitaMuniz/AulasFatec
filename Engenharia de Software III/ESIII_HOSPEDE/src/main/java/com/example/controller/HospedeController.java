package com.example.controller;

import com.example.fachada.Fachada;
import com.example.model.Hospede;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

import java.io.IOException;

@WebServlet(name = "HospedeController", urlPatterns = {"/hospede"})
public class HospedeController extends HttpServlet {

    private Fachada fachada = Fachada.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if (action == null || action.equals("list")) {

                String nome = req.getParameter("nome");
                String cpf = req.getParameter("cpf");
                String email = req.getParameter("email");
                String telefone = req.getParameter("telefone");

                boolean existeFiltro =
                        (nome != null && !nome.isBlank()) ||
                                (cpf != null && !cpf.isBlank()) ||
                                (email != null && !email.isBlank()) ||
                                (telefone != null && !telefone.isBlank());

                if (existeFiltro) {
                    req.setAttribute("hospedes", fachada.buscarComFiltro(nome, cpf, email, telefone));
                } else {
                    req.setAttribute("hospedes", fachada.listarHospedes());
                }

                req.getRequestDispatcher("/hospede_list.jsp").forward(req, resp);
                return;
            }

            if (action.equals("form")) {
                req.getRequestDispatcher("/hospede_form.jsp").forward(req, resp);
                return;
            }

            if (action.equals("edit")) {
                Long id = Long.parseLong(req.getParameter("id"));
                Hospede h = fachada.buscarHospede(id);
                req.setAttribute("hospede", h);
                req.getRequestDispatcher("/hospede_form.jsp").forward(req, resp);
                return;
            }

            if (action.equals("delete")) {
                Long id = Long.parseLong(req.getParameter("id"));
                fachada.excluirHospede(id);
                resp.sendRedirect(req.getContextPath() + "/hospede?action=list");
                return;
            }
        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("/hospede_list.jsp").forward(req, resp);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if (!action.equals("save"))
                return;

            Hospede h = new Hospede();

            if (req.getParameter("id") != null && !req.getParameter("id").isEmpty())
                h.setId(Long.parseLong(req.getParameter("id")));

            h.setNome(req.getParameter("nome"));
            h.setCpf(req.getParameter("cpf"));
            h.setEmail(req.getParameter("email"));
            h.setTelefone(req.getParameter("telefone"));
            h.setCelular(req.getParameter("celular"));
            h.setDataNascimento(req.getParameter("data_nascimento"));
            String senhaForm = req.getParameter("senha");
            if (h.getId() != null && (senhaForm == null || senhaForm.isBlank())) {
                Hospede antigo = fachada.buscarHospede(h.getId());
                h.setSenha(antigo.getSenha());
            } else {
                h.setSenha(senhaForm);
            }

            h.setAtivo(req.getParameter("ativo") != null);

            if (h.getId() == null) fachada.salvarHospede(h);
            else fachada.alterarHospede(h);

            String[] logradouros = req.getParameterValues("logradouro[]");
            String[] numeros = req.getParameterValues("numero[]");
            String[] complementos = req.getParameterValues("complemento[]");
            String[] bairros = req.getParameterValues("bairro[]");
            String[] cidades = req.getParameterValues("cidade[]");
            String[] estados = req.getParameterValues("estado[]");

            com.example.dao.EstadoDAO estadoDAO = new com.example.dao.EstadoDAO();
            com.example.dao.CidadeDAO cidadeDAO = new com.example.dao.CidadeDAO();
            com.example.dao.EnderecoDAO enderecoDAO = new com.example.dao.EnderecoDAO();

            enderecoDAO.excluirPorHospede(h.getId());

            if (logradouros != null) {
                for (int i = 0; i < logradouros.length; i++) {

                    if (logradouros[i] == null || logradouros[i].isBlank())
                        continue;

                    String estadoNome = estados[i];
                    String cidadeNome = cidades[i];

                    var estado = estadoDAO.buscarPorNomeOuCriar(estadoNome);
                    var cidade = cidadeDAO.buscarPorNomeEEstadoOuCriar(cidadeNome, estado);

                    com.example.model.Endereco e = new com.example.model.Endereco();
                    e.setHospede(h);
                    e.setEstado(estado);
                    e.setCidade(cidade);
                    e.setLogradouro(logradouros[i]);
                    e.setNumero(numeros[i]);
                    e.setComplemento(complementos[i]);
                    e.setBairro(bairros[i]);

                    enderecoDAO.salvar(e);
                }
            }

            resp.sendRedirect(req.getContextPath() + "/hospede?action=list");

        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("/hospede_form.jsp").forward(req, resp);
        }
    }
}
