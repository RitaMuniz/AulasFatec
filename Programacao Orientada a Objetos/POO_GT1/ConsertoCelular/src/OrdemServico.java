import java.util.ArrayList;
import java.util.List;

public class OrdemServico {

    private static int contador = 1;
    private int numero;
    private Cliente cliente;
    private Celular celular;
    private String descricao;
    private String status = "Aberta";
   private List<Materiais> materiaisUsados = new ArrayList<>();

    public OrdemServico(Cliente cliente, Celular celular, String descricao) {
        this.numero = contador++;
        this.cliente = cliente;
        this.celular = celular;
        this.descricao = descricao;
    }

    public void concluir() {
        status = "Concluída";
    }

    public void enviarMensagem() {
        System.out.println("Entrando em contato com cliente através de: https://wa.me/55" + cliente.getTelefone());
        System.out.println("Mensagem: Olá " + cliente + "! Seu aparelho já está pronto para ser retirado!");
    }

    public void adicionarMaterial(Materiais materiais) {
        materiaisUsados.add(materiais);
    }

    @Override
    public String toString() {
        return "OS#" + numero + " | Cliente: " + cliente.getNome() +
                " | Aparelho: " + celular +
                " | Problema: " + descricao +
                " | Status: " + status +
                " | Peças usadas: " + materiaisUsados;
    }
}