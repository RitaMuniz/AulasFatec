package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import projetoLivraria.dao.CidadeDAO;
import projetoLivraria.dao.EstadoDAO;
import projetoLivraria.dao.PaisDAO;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.service.ClienteService;

import java.io.IOException;
import java.util.List;

public class EnderecoController extends HttpServlet {

    private final ClienteService service = new ClienteService();
    private CidadeDAO cidadeDAO = new CidadeDAO();
    private EstadoDAO estadoDAO = new EstadoDAO();
    private PaisDAO paisDAO = new PaisDAO();

    private Cliente getClienteLogado(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("clienteLogado") == null) {
            resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
            return null;
        }
        return (Cliente) session.getAttribute("clienteLogado");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cliente clienteLogado = getClienteLogado(req, resp);
        if (clienteLogado == null) return;

        String action = req.getParameter("action");
        if (action == null) action = "listar";

        // guarda origem na sessão para redirecionar corretamente após salvar
        String origem = req.getParameter("origem");
        if (origem != null) {
            req.getSession().setAttribute("enderecoOrigem", origem);
        }

        try {
            switch (action) {
                case "listar":
                    List<Endereco> enderecos = service.listarEnderecos(clienteLogado.getId());
                    req.setAttribute("enderecos", enderecos);
                    req.setAttribute("estados", estadoDAO.listar());
                    req.setAttribute("paises", paisDAO.listar());
                    req.getRequestDispatcher("/view/enderecos.jsp").forward(req, resp);
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/endereco?action=listar");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao listar endereços.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Cliente clienteLogado = getClienteLogado(req, resp);
        if (clienteLogado == null) return;

        String action = req.getParameter("action");
        if (action == null) action = "adicionar";

        try {
            switch (action) {

                case "adicionar":
                    Endereco novo = new Endereco();
                    novo.setClienteId(clienteLogado.getId());
                    novo.setTipoEndereco(req.getParameter("tipoEndereco"));
                    novo.setTipoResidencia(req.getParameter("tipoResidencia"));
                    novo.setTipoLogradouro(req.getParameter("tipoLogradouro"));
                    novo.setLogradouro(req.getParameter("logradouro"));
                    novo.setNumero(req.getParameter("numeroEndereco"));
                    novo.setBairro(req.getParameter("bairro"));
                    novo.setCep(req.getParameter("cep"));
                    novo.setObservacoes(req.getParameter("observacoes"));

                    String cidadeNome = req.getParameter("cidadeNome");
                    String estadoId = req.getParameter("estadoId");

                    if (cidadeNome != null && !cidadeNome.isEmpty() &&
                            estadoId != null && !estadoId.isEmpty()) {
                        int cidadeId = cidadeDAO.buscarOuCriar(cidadeNome, Integer.parseInt(estadoId));
                        novo.setCidadeId(cidadeId);
                    }

                    service.adicionarEndereco(novo);
                    resp.sendRedirect(resolverRedirect(req, "/endereco?action=listar"));
                    break;

                case "editar":
                    Endereco edit = new Endereco();
                    edit.setId(Integer.parseInt(req.getParameter("id")));
                    edit.setClienteId(clienteLogado.getId());
                    edit.setTipoEndereco(req.getParameter("tipoEndereco"));
                    edit.setTipoResidencia(req.getParameter("tipoResidencia"));
                    edit.setTipoLogradouro(req.getParameter("tipoLogradouro"));
                    edit.setLogradouro(req.getParameter("logradouro"));
                    edit.setNumero(req.getParameter("numeroEndereco"));
                    edit.setBairro(req.getParameter("bairro"));
                    edit.setCep(req.getParameter("cep"));
                    edit.setObservacoes(req.getParameter("observacoes"));

                    String cidadeNomeEdit = req.getParameter("cidadeNome");
                    String estadoIdEdit = req.getParameter("estadoId");

                    if (cidadeNomeEdit != null && !cidadeNomeEdit.isEmpty() &&
                            estadoIdEdit != null && !estadoIdEdit.isEmpty()) {
                        int cidadeIdEdit = cidadeDAO.buscarOuCriar(cidadeNomeEdit, Integer.parseInt(estadoIdEdit));
                        edit.setCidadeId(cidadeIdEdit);
                    }

                    service.editarEndereco(edit);
                    resp.sendRedirect(resolverRedirect(req, "/endereco?action=listar"));
                    break;

                case "excluir":
                    int id = Integer.parseInt(req.getParameter("id"));
                    service.excluirEndereco(id);
                    resp.sendRedirect(resolverRedirect(req, "/endereco?action=listar"));
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/endereco?action=listar");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar endereço.");
        }
    }

    /** Redireciona para /pedido se veio do checkout, senão para o destino padrão */
    private String resolverRedirect(HttpServletRequest req, String padrao) {
        HttpSession session = req.getSession();
        String origem = (String) session.getAttribute("enderecoOrigem");
        if ("checkout".equals(origem)) {
            session.removeAttribute("enderecoOrigem");
            return req.getContextPath() + "/pedido";
        }
        return req.getContextPath() + padrao;
    }
}