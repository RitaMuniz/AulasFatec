import java.util.Scanner;

//Rita de Cassia Muniz de Lima

public class Main {

    public static boolean verificaCPF(String cpf) {
        int soma = 0;

        for (int i=0; i<9; i++) {
            soma += Integer.parseInt(String.valueOf(cpf.charAt(i))) * (10-i);
        }

        int dv1 = soma%11;

        if (dv1 <= 2) { dv1 = 0; } else { dv1 = 11 - dv1; }

        if(dv1 == Integer.parseInt(String.valueOf(cpf.charAt(9)))) {
            soma = 0;
            for (int i=0; i<10; i++) {
                soma += Integer.parseInt(String.valueOf(cpf.charAt(i))) * (11-i);
            }

            int dv2 = soma % 11;

            if (dv2 <= 2) { dv2 = 0; } else { dv2 = 11 - dv2; }

            return (dv2 == Integer.parseInt(String.valueOf(cpf.charAt(10))));
        }

        return false;
    }

    public static void main(String[] args) {
        String cpf;

        Scanner scanner = new Scanner(System.in);
        System.out.println("\nValidador de CPF");
        System.out.println("Digita seu cpf (sem ponto ou traço): ");
        cpf = scanner.nextLine();

        if (verificaCPF(cpf)) {
            System.out.println("Seu cpf eh valido!");
        } else {
            System.out.println("Cpf invalido!");
        }
    }
}