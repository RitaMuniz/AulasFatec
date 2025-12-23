//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        Gato gato = new Gato("Miau", "Peixe", "Felino");

        System.out.println("Informações do gato: ");
        System.out.println("Tipo: " + gato.getTipo());
        System.out.println("Comida: " + gato.getComida());
        gato.miar();
        gato.parar();
        gato.comer();
        gato.dormir();

        Leao leao = new Leao("Roar", "Carne", "Felino");
        System.out.println("Informações do leao: ");
        System.out.println("Tipo: " + leao.getTipo());
        System.out.println("Comida: " + leao.getComida());
        leao.rugir();
        leao.parar();
        leao.comer();
        leao.dormir();


    }
}