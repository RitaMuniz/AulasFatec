import java.util.Scanner;

public class Main {
    public static void main(String[] args) {

        int escolha;
        double valor1 = 0;
        double valor2 = 0;
        Scanner scanner = new Scanner(System.in);

        System.out.printf("""
                Calculadora
                
                Quer fazer calculo do que?
                Soma: Digite 1
                Subtracao: Digite 2
                Divisao: Digite 3
                Multiplicacao: Digite 4
                Exponencial: Digita 5
                Raiz Quadrada: Digite 6
                Digite: 
                """);
        escolha = scanner.nextInt();

        if (escolha < 6) {
            System.out.println("Valor 1: ");
            valor1 = scanner.nextDouble();

            System.out.println("Valor 2: ");
            valor2 = scanner.nextDouble();
        }
        else if (escolha == 6) {
            System.out.println("Valor 1: ");
            valor1 = scanner.nextDouble();
        }

        switch (escolha) {
            case 1: System.out.printf("Resultado: %.2f", Operacoes.soma(valor1, valor2)); break;
            case 2: System.out.printf("Resultado: %.2f", Operacoes.subtrair(valor1, valor2)); break;
            case 3: System.out.printf("Resultado: %.2f", Operacoes.dividir(valor1, valor2)); break;
            case 4: System.out.printf("Resultado: %.2f", Operacoes.multiplicar(valor1, valor2)); break;
            case 5: System.out.printf("Resultado: %.2f", Operacoes.exponencial(valor1, valor2)); break;
            case 6: System.out.printf("Resultado: %.2f", Operacoes.raiz(valor1)); break;
            default:
                System.out.println("Erro");
        }
    }
}