import java.util.Scanner;

/*
Felipe Cavalcante Tolentino Gonçalves
Rita de Cássia Muniz de Lima
 */

public class Main {
    public static void main(String[] args) {

        String nome;
        float salGrosso;
        float inss;
        float vt;
        float ir;
        float ps;
        float fgts;
        float salRefinado;
        float feriasBrutas;
        float feriasReais;
        float vtferias;
        float irferias;

        Scanner scanner = new Scanner(System.in);
        System.out.println("Calculo de salário");
        System.out.println("Insira seu nome completo: ");
        nome = scanner.nextLine();

        System.out.println("Coloca o seu salário: ");
        salGrosso = scanner.nextFloat();

        inss = 291.24F;
        vt = salGrosso*0.06F;
        ir = (salGrosso*0.075F-186.16F);
        ps = 280;
        fgts = salGrosso*0.08F;

        salRefinado = salGrosso - (inss + vt + ir + ps);

        System.out.printf("""
                \nOlá, %s! Seu salario bruto é de R$%.2f, Porém, voce tem que pagar:
                R$%.2f de inss;
                R$%.2f de vt;
                R$%.2f de plano de saude;
                R$%.2f de IR.
                Então, sobra pra você incriveis R$%.2f de salario liquido
                Ja o FGTS, voce receberá R$%.2f
                """, nome, salGrosso, inss, vt, ps, ir, salRefinado, fgts);

        feriasBrutas = salGrosso + (salGrosso/3);
        vtferias = feriasBrutas*0.06F;
        irferias = (feriasBrutas*0.075F-186.16F);

        feriasReais = feriasBrutas - (inss + vt + ir + ps);

        System.out.printf("""
                \n Seu salario bruto das ferias é de R$%.2f, Porém, voce tem que pagar:
                R$%.2f de inss;
                R$%.2f de vt;
                R$%.2f de plano de saude;
                R$%.2f de IR.
                Então, sobra pra você incriveis R$%.2f de salario liquido
                """, feriasBrutas, inss, vtferias, ps, irferias, feriasReais);
    }
}