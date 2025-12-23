import java.util.Scanner;

/*
O programa poderá ter como tema o gerenciamento de uma loja de conserto de celulares.
O sistema deverá controlar as ordens de serviço, ter um cadastro de clientes, modelos, peças,
controlar a entrada e saida de materiais e aparelhos.
Ter também mensagens para os clientes via whatsapp informando sobre retirada de aparelhos.

Construir diagramas e/r. O sistema deve obdecer ao que estiver escrito nele.
 */
public class Main {

    public static void main(String[] args) {

        System.out.println("Assistencia Tecnica");

        Scanner s = new Scanner(System.in);
        int op;

        do {
            System.out.println("""
                    \nMenu
                    
                    1 - Cadastrar cliente
                    2 - Cadastrar aparelho
                    3 - Cadastrar peça
                    4 - Abrir ordem de serviço
                    5 - Usar peça em ordem
                    6 - Concluir Ordem
                    7 - Listar ordens
                    0 - Sair""");
            System.out.print("Opção: ");
            op = s.nextInt();
            s.nextLine();

            switch (op) {
                case 1 -> Cadastros.cadastrarCliente(s);
                case 2 -> Cadastros.cadastrarCelular(s);
                case 3 -> Cadastros.cadastrarMaterial(s);
                case 4 -> Cadastros.abrirOrdem(s);
                case 5 -> Cadastros.usarMaterial(s);
                case 6 -> Cadastros.concluirOrdem(s);
                case 7 -> Cadastros.listarOrdens();
            }
        } while (op != 0);
    }
}