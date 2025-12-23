#include<stdio.h>

//Rita de Cassia Muniz de Lima
//Exemplo 13

//Função de troca
void troca (int *a, int *b) {
	//Variavel
     int c = *a; //Atribui a c valor de a
     *a = *b;	 //Aponta a pra b (a agora possui valor de b)
     *b = c;	//b aponta pra c (b tem valor de c)
}

//Funcao principal
int main (void) {
    int x;
    int y;
    
    printf("Troca de valores\n");
    printf("Valor a: ");
    scanf("%d", &x);
    printf("Valor b: ");
    scanf("%d", &y);
    
    //Manda os valores armazendos para funcao
    troca(&x, &y);
    
    //resposta
    printf("Valor a: %d\nvalor b: %d", x, y);
    
    return 0;
}
