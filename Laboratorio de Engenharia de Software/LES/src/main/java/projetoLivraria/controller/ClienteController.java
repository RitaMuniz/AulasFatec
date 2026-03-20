package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
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
                    int id = Integer.parseInt(req.getParameter("id"));
                    Cliente cliente = service.buscarCliente(id);
                    req.setAttribute("cliente", cliente);
                    req.getRequestDispatcher("/view/cliente.html").forward(req, resp);
                    break;

                default:
                    resp.sendRedirect("view/index.html");
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
                    novoCliente.setDataNascimento(Date.valueOf(req.getParameter("dataNascimento"))); // formato: YYYY-MM-DD
                    novoCliente.setCpf(req.getParameter("cpf"));
                    novoCliente.setEmail(req.getParameter("email"));
                    novoCliente.setSenha(req.getParameter("senha"));

                    Telefone telefone = new Telefone();
                    telefone.setTipo(req.getParameter("tipoTelefone"));
                    telefone.setDdd(req.getParameter("ddd"));
                    telefone.setNumero(req.getParameter("numeroTelefone"));

                    Endereco endereco = new Endereco();
                    endereco.setTipoLogradouro(req.getParameter("tipoLogradouro"));
                    endereco.setLogradouro(req.getParameter("logradouro"));
                    endereco.setTipoResidencia(req.getParameter("tipoResidencia"));
                    endereco.setNumero(req.getParameter("numeroEndereco"));
                    endereco.setBairro(req.getParameter("bairro"));
                    endereco.setCep(req.getParameter("cep"));
                    endereco.setObservacoes(req.getParameter("observacoes"));
                    endereco.setTipoEndereco(req.getParameter("tipoEndereco")); // "ENTREGA" ou "COBRANCA"

                    String cidadeIdStr = req.getParameter("cidadeId");
                    if (cidadeIdStr != null && !cidadeIdStr.isEmpty()) {
                        endereco.setCidadeId(Integer.parseInt(cidadeIdStr));
                    }

                    service.cadastrarCliente(novoCliente, telefone, endereco);
                    resp.sendRedirect(req.getContextPath() + "/view/login.html");
                    break;

                case "editar":
                    Cliente clienteEdit = new Cliente();
                    clienteEdit.setId(Integer.parseInt(req.getParameter("id")));
                    clienteEdit.setNome(req.getParameter("nome"));
                    clienteEdit.setGenero(req.getParameter("genero"));
                    clienteEdit.setDataNascimento(Date.valueOf(req.getParameter("dataNascimento")));
                    clienteEdit.setEmail(req.getParameter("email"));

                    service.editarCliente(clienteEdit);
                    resp.sendRedirect(req.getContextPath() + "/cliente?action=buscar&id=" + clienteEdit.getId());
                    break;

                case "desativar":
                    int desativarId = Integer.parseInt(req.getParameter("id"));
                    service.desativarCliente(desativarId);
                    resp.sendRedirect(req.getContextPath() + "/cliente?action=listar");
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