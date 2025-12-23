/*
* ex15: Explique encapsulamento com um exemplo simples.
*/
public class Livro {

    private double valor; //não acessado facilmente (privado a essa classe)

    //Metodos que permitem acesso controlado a variavel
    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        if(valor > 0) {
            this.valor = valor;
        }
    }
}