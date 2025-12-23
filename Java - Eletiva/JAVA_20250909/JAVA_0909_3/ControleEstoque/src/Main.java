import java.util.HashMap;
import java.util.Random;

/*
Crie um programa Java que controle o estoque de uma loja.
Esta loja tem 4 produtos: A, B, C, D. O estoque inicial destes produtos é:

produto Qtde inicial Valor unidade  | produto Qtde inicial Valor unidade
A           12          15,50       |    C           14          10,00
B           12          21,99       |    D           82          14,99

O programa deverá avisar ao proprietário quando o estoque está baixo e precisa de reposição.
A métrica será de 20% do estoque inicial de cada produto para emitir o aviso.
Ele avisa, mas não bloqueia a venda. A venda de determinado produto só é bloqueada caso o estoque zerar.
O programa deverá rodar por 100 vezes simulando compras aleatoriamente.
Ao final deverá mostrar um relatório de quantas unidades de cada produto foram vendidas,
o valor em vendas realizado e quais produtos precisam de reposição.

Considerando a tabela abaixo, calcule com base nas vendas realizadas qual foi o lucro bruto.

PRODUTO-MARGEM DE LUCRO: A: 150%     B: 80%     C: 5%    D: 2%

Calcule também, baseado na tabela anterior qual será o custo para recompor o estoque até a situação inicial,
e qual será o lucro líquido total da empresa
*/
public class Main {

    public static void main(String[] args) {

        HashMap<Integer, Produtos> estoque = new HashMap<>();
        estoque.put(1, new Produtos("A", 12, 15.50, 1.50)); //Lucro é o Markup (aumento em cima do custo)
        estoque.put(2, new Produtos("B", 12, 21.99, 0.8));
        estoque.put(3, new Produtos("C", 14, 10, 0.05));
        estoque.put(4, new Produtos("D", 82, 14.99, 0.02));

        System.out.println("""
                Simulador de Controle de estoque
                Simulação: 100 compras
                
                Começando simulação...""");
        for (int i=0; i<100; i++) {
            Random random = new Random();
            estoque.get(random.nextInt(1, 5)).compra(random.nextInt(1, 5));
        }

        System.out.println("Fim da simulação\n");

        System.out.println("""
                RELATÓRIO
                Produto A:
                           Qtde. vendidos:  %d
                           Lucro Bruto:     R$%.2f 
                           Lucro Liquido:   R$%.2f 
                           Custo reposicao: R$%.2f
                Produto B: 
                           Qtde. vendidos:  %d
                           Lucro Bruto:     R$%.2f 
                           Lucro Liquido:   R$%.2f 
                           Custo reposicao: R$%.2f
                Produto C: 
                           Qtde. vendidos:  %d
                           Lucro Bruto:     R$%.2f 
                           Lucro Liquido:   R$%.2f 
                           Custo reposicao: R$%.2f
                Produto D: 
                           Qtde. vendidos:  %d
                           Lucro Bruto:     R$%.2f 
                           Lucro Liquido:   R$%.2f 
                           Custo reposicao: R$%.2f
                           """.formatted(
                                   estoque.get(1).getQtdVendido(), estoque.get(1).getTotalFaturado(), estoque.get(1).getLucroLiquido(), estoque.get(1).getCusto(),
                                   estoque.get(2).getQtdVendido(), estoque.get(2).getTotalFaturado(), estoque.get(2).getLucroLiquido(), estoque.get(2).getCusto(),
                                   estoque.get(3).getQtdVendido(), estoque.get(3).getTotalFaturado(), estoque.get(3).getLucroLiquido(), estoque.get(3).getCusto(),
                                   estoque.get(4).getQtdVendido(), estoque.get(4).getTotalFaturado(), estoque.get(4).getLucroLiquido(), estoque.get(4).getCusto()));
    }
}