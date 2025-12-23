public class Leao extends Animal{

    public Leao (String som, String comida, String tipo) {
        super(som, comida, tipo);
    }

    public void rugir() {
        System.out.println("O leão está rugindo: " + getSom());
    }

}
