import java.util.Scanner;

public class Main {
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        int forma;
        double lado1;
        double lado2;
        double lado3;
        double apotema;
        double comprimento;

        System.out.println("Calculadora de Area, Perimetro e Volume de uma forma geomátrica");
        System.out.println("""
                Circulo (Esfera): digite 1
                Triangulo (Pirâmide de 3 lados): digite 2
                Quadrado (Cubo): digite 3
                Retangulo (Paralelepípedo): digite 4
                Pentagono (Prisma Pentagonal): digite 5
                Hexagono (Prisma Hexagonal): digite 6
                
                (Observação: A calculadora só aceita Pentagonos e hexagonos regulares (lados iguais))
                
                Qual vai escolher?""");

        forma = scanner.nextInt();

        switch (forma) {
            case 1:
                System.out.println("""
                        Calculo do Circulo
                        Digite o tamanho do raio: """);
                double raio = scanner.nextDouble();

                Circulo circulo = new Circulo(raio);
                System.out.printf("""
                    Area: %.2f
                    Perimetro: %.2f
                    Volume (Esfera): %.2f""",
                        circulo.calcularArea(),
                        circulo.calcularPerimetro(),
                        circulo.calcularVolume());

                break;

            case 2:
                System.out.println("""
                        Calculo do Triangulo
                        Digite o tamanho do base: """);
                lado1= scanner.nextDouble();

                System.out.println("Tamanho do lado 2: ");
                lado2 = scanner.nextDouble();

                System.out.println("Tamanho do lado 3:");
                lado3 = scanner.nextDouble();
                System.out.println("Altura: ");
                comprimento = scanner.nextDouble();

                Triangulo triangulo = new Triangulo(lado1, lado2, lado3, comprimento);
                System.out.printf("""
                    Area: %.2f
                    Perimetro: %.2f
                    Volume (Piramide Triangular): %.2f""",
                        triangulo.calcularArea(),
                        triangulo.calcularPerimetro(),
                        triangulo.calcularVolume());

                break;

            case 3:
                System.out.println("""
                        Calculo do Quadrado
                        Digite o tamanho de um dos lados: """);
                lado1= scanner.nextDouble();

                Quadrado quadrado = new Quadrado(lado1);
                System.out.printf("""
                    Area: %.2f
                    Perimetro: %.2f
                    Volume (Cubo): %.2f""",
                        quadrado.calcularArea(),
                        quadrado.calcularPerimetro(),
                        quadrado.calcularVolume());

                break;

            case 4:
                System.out.println("""
                        Calculo do Retangulo
                        Digite a largura: """);
                lado1= scanner.nextDouble();

                System.out.println("Digite a altura: ");
                lado2 = scanner.nextDouble();

                System.out.println("Digite o comprimento(para paralelepípedo): ");
                comprimento = scanner.nextDouble();

                Retangulo retangulo = new Retangulo(lado1, lado2, comprimento);
                System.out.printf("""
                    Area: %.2f
                    Perimetro: %.2f
                    Volume (Paralelepípedo): %.2f""",
                        retangulo.calcularArea(),
                        retangulo.calcularPerimetro(),
                        retangulo.calcularVolume());

                break;

            case 5:
                System.out.println("""
                        Calculo do Quadrado
                        Digite o tamanho do lado: """);
                lado1= scanner.nextDouble();

                System.out.println("Altura (do prisma): ");
                lado2 = scanner.nextDouble();

                System.out.println("Apotema: ");
                apotema = scanner.nextDouble();

                Pentagono pentagono = new Pentagono(lado1, lado2, apotema);
                System.out.printf("""
                    Area: %.2f
                    Perimetro: %.2f
                    Volume (Prisma Pentagonal): %.2f""",
                        pentagono.calcularArea(),
                        pentagono.calcularPerimetro(),
                        pentagono.calcularVolume());

                break;

            case 6:
                System.out.println("""
                        Calculo do Hexagono Regular (todos os lados iguais)
                        Digite o tamanho do lado: """);
                lado1= scanner.nextDouble();

                System.out.println("Apotema: ");
                apotema = scanner.nextDouble();

                System.out.println("Altura do prisma: ");
                lado2 = scanner.nextDouble();

                Hexagono hexagono = new Hexagono(lado1, apotema, lado2);
                System.out.printf("""
                    Area: %.2f
                    Perimetro: %.2f
                    Volume (Prisma Hexagonal): %.2f""",
                        hexagono.calcularArea(),
                        hexagono.calcularPerimetro(),
                        hexagono.calcularVolume());

                break;

            default:
                System.out.println("Erro: Você digitou um numero que não está listado.");
        }
    }
}