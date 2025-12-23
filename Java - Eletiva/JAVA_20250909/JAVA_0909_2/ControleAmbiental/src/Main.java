import java.util.Scanner;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        double temp;
        int umidade;
        boolean bao = true;

        System.out.println("""
                Controle Ambiental
                Insira a temperatura (em ºC): """);

        temp = scanner.nextDouble();

        System.out.println("Insira a umidade (%): ");
        umidade = scanner.nextInt();

        if (temp < 17.0) {
            System.out.println("Ação: Ligar aquecedores até atingir 20 graus");
            bao = false;
        }

        if (umidade < 70) {
            System.out.println("Ação: Ligar umidificador ");
            bao = false;
        }

        if (temp > 28) {
            System.out.println("Ação: Ligar resfriadores até atingir 24 graus");
            bao = false;
        }

        if (temp > 21  && temp <= 28) {
            System.out.println("Ação: Ligar Ventilação");
            bao = false;
        }

        if (bao) {
            System.out.println("Ação: nenhuma ação é necessária. O clima ta bão");
        }
    }
}