package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import projetoLivraria.model.Admin;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import projetoLivraria.service.ClienteException;
import projetoLivraria.service.ClienteService;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

public class ClienteController extends HttpServlet {

    private final ClienteService service = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "listar";

        try {
            switch (action) {
                case "listar":
                    String busca = req.getParameter("busca");
                    List<Cliente> clientes;
                    if (busca != null && !busca.trim().isEmpty()) {
                        clientes = service.buscarClientes(busca.trim());
                    } else {
                        clientes = service.listarClientes();
                    }
                    req.setAttribute("clientes", clientes);
                    req.getRequestDispatcher("/view/admin-clientes.jsp").forward(req, resp);
                    break;

                case "buscar":
                    req.getRequestDispatcher("/view/cliente.jsp").forward(req, resp);
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/view/index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erro ao processar requisição.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "cadastrar";

        try {
            switch (action) {

                case "cadastrar": {
                    Cliente novoCliente = new Cliente();
                    novoCliente.setNome(req.getParameter("nome"));
                    novoCliente.setGenero(req.getParameter("genero"));
                    novoCliente.setDataNascimento(Date.valueOf(req.getParameter("dataNascimento")));
                    novoCliente.setCpf(req.getParameter("cpf"));
                    novoCliente.setEmail(req.getParameter("email"));
                    novoCliente.setSenha(req.getParameter("senha"));

                    Telefone telefone = new Telefone();
                    telefone.setTipo(req.getParameter("tipoTelefone"));
                    telefone.setDdd(req.getParameter("ddd"));
                    telefone.setNumero(req.getParameter("numeroTelefone"));

                    Endereco enderecoEntrega = new Endereco();
                    enderecoEntrega.setTipoEndereco("ENTREGA");
                    enderecoEntrega.setTipoLogradouro(req.getParameter("tipoLogradouro"));
                    enderecoEntrega.setLogradouro(req.getParameter("logradouro"));
                    enderecoEntrega.setTipoResidencia(req.getParameter("tipoResidencia"));
                    enderecoEntrega.setNumero(req.getParameter("numeroEndereco"));
                    enderecoEntrega.setBairro(req.getParameter("bairro"));
                    enderecoEntrega.setCep(req.getParameter("cep"));
                    enderecoEntrega.setObservacoes(req.getParameter("observacoes"));
                    String cidadeId = req.getParameter("cidadeId");
                    if (cidadeId != null && !cidadeId.isEmpty()) {
                        enderecoEntrega.setCidadeId(Integer.parseInt(cidadeId));
                    }

                    Endereco enderecoCobranca = new Endereco();
                    enderecoCobranca.setTipoEndereco("COBRANCA");
                    String logradouroCobranca = req.getParameter("logradouroCobranca");
                    if (logradouroCobranca != null && !logradouroCobranca.trim().isEmpty()) {
                        enderecoCobranca.setTipoLogradouro(req.getParameter("tipoLogradouroCobranca"));
                        enderecoCobranca.setLogradouro(logradouroCobranca);
                        enderecoCobranca.setTipoResidencia(req.getParameter("tipoResidenciaCobranca"));
                        enderecoCobranca.setNumero(req.getParameter("numeroEnderecoCobranca"));
                        enderecoCobranca.setBairro(req.getParameter("bairroCobranca"));
                        enderecoCobranca.setCep(req.getParameter("cepCobranca"));
                        enderecoCobranca.setObservacoes(req.getParameter("observacoesCobranca"));
                        String cidadeIdCobranca = req.getParameter("cidadeIdCobranca");
                        if (cidadeIdCobranca != null && !cidadeIdCobranca.isEmpty()) {
                            enderecoCobranca.setCidadeId(Integer.parseInt(cidadeIdCobranca));
                        }
                    } else {
                        enderecoCobranca.setTipoLogradouro(enderecoEntrega.getTipoLogradouro());
                        enderecoCobranca.setLogradouro(enderecoEntrega.getLogradouro());
                        enderecoCobranca.setTipoResidencia(enderecoEntrega.getTipoResidencia());
                        enderecoCobranca.setNumero(enderecoEntrega.getNumero());
                        enderecoCobranca.setBairro(enderecoEntrega.getBairro());
                        enderecoCobranca.setCep(enderecoEntrega.getCep());
                        enderecoCobranca.setObservacoes(enderecoEntrega.getObservacoes());
                        enderecoCobranca.setCidadeId(enderecoEntrega.getCidadeId());
                    }

                    service.cadastrarCliente(novoCliente, telefone, enderecoEntrega, enderecoCobranca);
                    HttpSession session = req.getSession(false);

                    Cliente clienteLogado = null;
                    Admin adminLogado = null;

                    if (session != null) {
                        clienteLogado = (Cliente) session.getAttribute("clienteLogado");
                        adminLogado   = (Admin) session.getAttribute("adminLogado");
                    }

                    if (adminLogado != null) {
                        resp.sendRedirect(req.getContextPath() + "/cliente?action=listar");

                    } else if (clienteLogado != null) {
                        resp.sendRedirect(req.getContextPath() + "/view/cliente.jsp");

                    } else {
                        resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
                    }
                    break;
                }

                case "editar": {
                    Cliente clienteEdit = new Cliente();
                    clienteEdit.setId(Integer.parseInt(req.getParameter("id")));
                    clienteEdit.setNome(req.getParameter("nome"));
                    clienteEdit.setGenero(req.getParameter("genero"));
                    clienteEdit.setDataNascimento(Date.valueOf(req.getParameter("dataNascimento")));
                    clienteEdit.setEmail(req.getParameter("email"));

                    service.editarCliente(clienteEdit);

                    HttpSession session = req.getSession(false);
                    if (session != null) {
                        Cliente atualizado = service.buscarCliente(clienteEdit.getId());
                        session.setAttribute("clienteLogado", atualizado);
                    }
                    resp.sendRedirect(req.getContextPath() + "/view/cliente.jsp?sucesso=1");
                    break;
                }

                case "desativar": {
                    int desativarId = Integer.parseInt(req.getParameter("id"));
                    service.desativarCliente(desativarId);

                    HttpSession sessionDes = req.getSession(false);
                    if (sessionDes != null) {
                        Cliente logado = (Cliente) sessionDes.getAttribute("clienteLogado");
                        if (logado != null && logado.getId() == desativarId) {
                            sessionDes.invalidate();
                            resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
                            return;
                        }
                    }
                    resp.sendRedirect(req.getContextPath() + "/cliente?action=listar");
                    break;
                }

                case "reativar": {
                    int reativarId = Integer.parseInt(req.getParameter("id"));
                    service.reativarCliente(reativarId);
                    resp.sendRedirect(req.getContextPath() + "/cliente?action=listar");
                    break;
                }

                default:
                    resp.sendRedirect(req.getContextPath() + "/view/index.jsp");
            }

        } catch (ClienteException ce) {
            String paginaOrigem = resolverPaginaOrigem(action);
            req.setAttribute("erro", ce.getMessage());
            req.setAttribute("erroCodigo", ce.getCodigo().name());
            req.getRequestDispatcher(paginaOrigem).forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erro interno ao processar requisição.");
        }
    }

    private String resolverPaginaOrigem(String action) {
        return switch (action) {
            case "cadastrar" -> "/view/cadastro.jsp";
            case "editar"    -> "/view/cliente.jsp";
            default          -> "/view/index.jsp";
        };
    }
}