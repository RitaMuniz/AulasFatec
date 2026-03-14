package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import service.ClienteService;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "ClienteController", urlPatterns = {"/cliente"})

public class ClienteController extends HttpServlet {

    @Override
    protected void doGet (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {

            Cliente cliente = new Cliente();
            cliente.setNome(req.getParameter("nome"));
            cliente.setGenero(req.getParameter("genero"));
            cliente.setDataNascimento(Date.valueOf("DataNascimento"));
            cliente.setCpf(req.getParameter("cpf"));
            cliente.setEmail(req.getParameter("email"));
            cliente.setSenha(req.getParameter("senha"));

            Telefone telefone = new Telefone();
            telefone.setTipo(req.getParameter("tipoTelefone"));
            telefone.setDdd(req.getParameter("ddd"));
            telefone.setNumero(req.getParameter("numero"));

            Endereco endereco = new Endereco();
            endereco.setLogradouro(req.getParameter("logradouro"));
            endereco.setNumero(req.getParameter("numeroEndereco"));
            endereco.setBairro(req.getParameter("bairro"));
            endereco.setCep(req.getParameter("cep"));

            ClienteService service = new ClienteService();
            service.cadastrarCliente(cliente, telefone, endereco);

            resp.sendRedirect("cliente-sucesso.html");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
    }
}
