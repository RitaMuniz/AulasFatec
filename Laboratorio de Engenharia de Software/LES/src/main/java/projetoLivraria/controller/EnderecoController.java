package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import projetoLivraria.model.Endereco;
import projetoLivraria.service.ClienteService;

import java.io.IOException;
import java.util.List;

public class EnderecoController extends HttpServlet {

    private final ClienteService service = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "listar";

        try {
            switch (action) {
                case "listar":
                    // clienteId virá da sessão quando sessão estiver implementada
                    int clienteId = Integer.parseInt(req.getParameter("clienteId"));
                    List<Endereco> enderecos = service.listarEnderecos(clienteId);
                    req.setAttribute("enderecos", enderecos);
                    req.getRequestDispatcher("/view/enderecos.html").forward(req, resp);
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/view/enderecos.html");
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
        if (action == null) action = "adicionar";

        try {
            switch (action) {

                case "adicionar":
                    Endereco novo = new Endereco();
                    novo.setClienteId(Integer.parseInt(req.getParameter("clienteId")));
                    novo.setTipoEndereco(req.getParameter("tipoEndereco"));
                    novo.setTipoResidencia(req.getParameter("tipoResidencia"));
                    novo.setTipoLogradouro(req.getParameter("tipoLogradouro"));
                    novo.setLogradouro(req.getParameter("logradouro"));
                    novo.setNumero(req.getParameter("numeroEndereco"));
                    novo.setBairro(req.getParameter("bairro"));
                    novo.setCep(req.getParameter("cep"));
                    novo.setObservacoes(req.getParameter("observacoes"));

                    String cidadeIdStr = req.getParameter("cidadeId");
                    if (cidadeIdStr != null && !cidadeIdStr.isEmpty()) {
                        novo.setCidadeId(Integer.parseInt(cidadeIdStr));
                    }

                    service.adicionarEndereco(novo);
                    resp.sendRedirect(req.getContextPath() + "/view/enderecos.html");
                    break;

                case "editar":
                    Endereco edit = new Endereco();
                    edit.setId(Integer.parseInt(req.getParameter("id")));
                    edit.setTipoEndereco(req.getParameter("tipoEndereco"));
                    edit.setTipoResidencia(req.getParameter("tipoResidencia"));
                    edit.setTipoLogradouro(req.getParameter("tipoLogradouro"));
                    edit.setLogradouro(req.getParameter("logradouro"));
                    edit.setNumero(req.getParameter("numeroEndereco"));
                    edit.setBairro(req.getParameter("bairro"));
                    edit.setCep(req.getParameter("cep"));
                    edit.setObservacoes(req.getParameter("observacoes"));

                    String cidadeIdEditStr = req.getParameter("cidadeId");
                    if (cidadeIdEditStr != null && !cidadeIdEditStr.isEmpty()) {
                        edit.setCidadeId(Integer.parseInt(cidadeIdEditStr));
                    }

                    service.editarEndereco(edit);
                    resp.sendRedirect(req.getContextPath() + "/view/enderecos.html");
                    break;

                case "excluir":
                    int id = Integer.parseInt(req.getParameter("id"));
                    service.excluirEndereco(id);
                    resp.sendRedirect(req.getContextPath() + "/view/enderecos.html");
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/view/enderecos.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar requisição.");
        }
    }
}
