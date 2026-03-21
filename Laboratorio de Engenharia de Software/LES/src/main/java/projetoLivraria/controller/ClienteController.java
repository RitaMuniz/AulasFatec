package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import projetoLivraria.model.Cliente;
import projetoLivraria.service.ClienteService;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

public class ClienteController extends HttpServlet {

    private final ClienteService service = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "listar";

        try {
            switch (action) {
                case "listar":
                    List<Cliente> clientes = service.listarClientes();
                    req.setAttribute("clientes", clientes);
                    req.getRequestDispatcher("/view/admin-clientes.html").forward(req, resp);
                    break;

                case "buscar":
                    req.getRequestDispatcher("/view/cliente.jsp").forward(req, resp);
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/view/index.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar requisição.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "cadastrar";

        try {
            switch (action) {

                case "cadastrar":
                    Cliente novoCliente = new Cliente();
                    novoCliente.setNome(req.getParameter("nome"));
                    novoCliente.setGenero(req.getParameter("genero"));
                    novoCliente.setDataNascimento(Date.valueOf(req.getParameter("dataNascimento")));
                    novoCliente.setCpf(req.getParameter("cpf"));
                    novoCliente.setEmail(req.getParameter("email"));
                    novoCliente.setSenha(req.getParameter("senha"));

                    projetoLivraria.model.Telefone telefone = new projetoLivraria.model.Telefone();
                    telefone.setTipo(req.getParameter("tipoTelefone"));
                    telefone.setDdd(req.getParameter("ddd"));
                    telefone.setNumero(req.getParameter("numeroTelefone"));

                    projetoLivraria.model.Endereco endereco = new projetoLivraria.model.Endereco();
                    endereco.setTipoLogradouro(req.getParameter("tipoLogradouro"));
                    endereco.setLogradouro(req.getParameter("logradouro"));
                    endereco.setTipoResidencia(req.getParameter("tipoResidencia"));
                    endereco.setNumero(req.getParameter("numeroEndereco"));
                    endereco.setBairro(req.getParameter("bairro"));
                    endereco.setCep(req.getParameter("cep"));
                    endereco.setObservacoes(req.getParameter("observacoes"));
                    endereco.setTipoEndereco(req.getParameter("tipoEndereco"));

                    String cidadeIdStr = req.getParameter("cidadeId");
                    if (cidadeIdStr != null && !cidadeIdStr.isEmpty()) {
                        endereco.setCidadeId(Integer.parseInt(cidadeIdStr));
                    }

                    service.cadastrarCliente(novoCliente, telefone, endereco);
                    resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
                    break;

                case "editar":
                    Cliente clienteEdit = new Cliente();
                    clienteEdit.setId(Integer.parseInt(req.getParameter("id")));
                    clienteEdit.setNome(req.getParameter("nome"));
                    clienteEdit.setGenero(req.getParameter("genero"));
                    clienteEdit.setDataNascimento(Date.valueOf(req.getParameter("dataNascimento")));
                    clienteEdit.setEmail(req.getParameter("email"));

                    service.editarCliente(clienteEdit);

                    HttpSession session = req.getSession(false);
                    if (session != null) {
                        Cliente clienteAtualizado = service.buscarCliente(clienteEdit.getId());
                        session.setAttribute("clienteLogado", clienteAtualizado);
                    }

                    resp.sendRedirect(req.getContextPath() + "/cliente?action=buscar");
                    break;

                case "desativar":
                    int desativarId = Integer.parseInt(req.getParameter("id"));
                    service.desativarCliente(desativarId);

                    HttpSession sessionDesativar = req.getSession(false);
                    if (sessionDesativar != null) sessionDesativar.invalidate();

                    resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/view/index.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar requisição.");
        }
    }
}