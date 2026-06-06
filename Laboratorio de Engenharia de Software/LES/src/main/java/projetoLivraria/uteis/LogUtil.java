package projetoLivraria.uteis;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.Admin;

public class LogUtil {

    /**
     * Retorna o identificador do usuário logado na sessão.
     * Funciona tanto para Cliente quanto para Admin.
     */
    public static String getUsuarioLogado(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return "anonimo";

        // Tenta pegar cliente logado
        Cliente cliente = (Cliente) session.getAttribute("cliente");
        if (cliente != null) {
            return "cliente:" + cliente.getEmail(); // ou getId(), getNome()
        }

        // Tenta pegar admin logado
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin != null) {
            return "admin:" + admin.getEmail();
        }

        return "anonimo";
    }
}