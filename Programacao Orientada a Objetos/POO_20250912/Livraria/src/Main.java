import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        int escolha;
        Scanner s = new Scanner(System.in);
        Carrinho c = new Carrinho();
        Livro l = new Livro();
        String nome, contato, cpf, logradouro, numero, complemento, cep, cidade, estado, pais, pgto;

        System.out.println("""
            Livraria Fictícia
            
            Gostaria de ver os livros disponíveis?
            1: Sim
            2: Nao
            Escolha: """);
        escolha = s.nextInt();

        if (escolha == 1) {
            do {
                System.out.println("""
                    Qual categoria de livros te interessa?
                    
                    1: Administração
                    2: Computação Gráfica
                    3: Eletrônica
                    4: Internet
                    5: Sistemas Operacionais
                    6: Telecomunicações
                    
                    Escolha: """);
                escolha = s.nextInt();

                if (escolha >= 1 && escolha <= 6) {
                    l.mostrarLivros(escolha, c);

                } else {
                    System.out.println("Erro: categoria inválida.");
                    return;
                }

                System.out.println("Gostaria de ver mais livros? 1:SIM; 2:NAO");
                escolha = s.nextInt();
            } while (escolha == 1);
        } else if (escolha == 2) {
            System.out.println("Tudo bem então. Até a próxima!");
            return;
        } else {
            System.out.println("Erro! Você digitou algo que não está certo.");
            return;
        }

        c.listar();

        System.out.println("Para finalizar sua compra, é necessário fazer o cadastro de usuario. Deseja continuar? 1:SIM; 2:NAO");
        escolha = s.nextInt();
        s.nextLine();

        if (escolha == 1) {
            System.out.print("Digite seu Nome: ");
            nome = s.nextLine();
            System.out.print("Contato: ");
            contato = s.nextLine();
            System.out.print("CPF: ");
            cpf = s.nextLine();
            System.out.print("Logradouro: ");
            logradouro = s.nextLine();
            System.out.print("Número: ");
            numero = s.nextLine();
            System.out.print("Complemento: ");
            complemento = s.nextLine();
            System.out.print("CEP: ");
            cep = s.nextLine();
            System.out.print("Cidade: ");
            cidade = s.nextLine();
            System.out.print("Estado: ");
            estado = s.nextLine();
            System.out.print("País: ");
            pais = s.nextLine();
        } else {
            System.out.println("Tudo bem então. Até a próxima!");
            return;
        }

        Usuario u = new Usuario(nome, contato, cpf, logradouro, numero, complemento, cep, cidade, estado, pais);

        System.out.printf("""
            Olá %s!
            Sua compra está quase sendo finalizada. Agora escolha a forma de Pagamento:
            
            1: Pix
            2: Cartão Débito
            3: Cartão Crédito
            4: Boleto
            
            Digite a opção: """, u.getNome());
        escolha = s.nextInt();

        if (escolha == 1) pgto = FormaPagamento.PIX.toString();
        else if (escolha == 2) pgto = FormaPagamento.DEBITO.toString();
        else if (escolha == 3) pgto = FormaPagamento.CREDITO.toString();
        else if (escolha == 4) pgto = FormaPagamento.BOLETO.toString();
        else {
            System.out.println("Erro: forma de pagamento inválida.");
            return;
        }

        System.out.println("Confirmando os dados: ");
        c.listar();
        System.out.println("Pagamento: " + pgto);
        u.mostrarDados();
        System.out.println("\nConfirma? 1:SIM; 2:NAO");
        escolha = s.nextInt();

        if (escolha == 1) {
            System.out.println("Compra realizada com sucesso!");
        } else {
            System.out.println("Tudo bem então. Até a próxima!");
        }
    }
}