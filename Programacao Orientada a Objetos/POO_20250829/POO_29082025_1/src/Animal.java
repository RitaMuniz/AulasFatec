/*
* ex8: Crie uma classe abstrata Animal com método abstrato fazerSom().
* ex10: Crie um método que recebe um Animal e chama fazerSom(). Use polimorfismo.
*/
public abstract class Animal {

    public abstract void fazerSom();

    //ex10
    public void emitirSom(Animal animal) {
        animal.fazerSom();
    }
}