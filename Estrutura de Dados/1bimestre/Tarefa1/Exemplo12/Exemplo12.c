#include<stdio.h>

//Rita de Cassia Muniz de Lima
//Exemplo 12: Passagem por valor

//Função troca
void troca (int a, int b) {
     //variaveis
	 int c=a;
	 
     a=b; //a recebe b
     b=c; //b recebe c
}

//Função principal
int main (void) {
    //Variaveis
	int x;
    int y;
    
    //Usuario
    printf("Troca de valores\n");
    printf("Digite um valor: ");
    scanf("%d", &x);
    printf("Digite outro valor: ");
    scanf("%d", &y);
    
    //Chama função
    troca(x,y); //não vai funcionar
    
    //Resposta
    printf("primeiro valor: %d \n segundo valor: %d", x, y); //Não vai funconar como esperado
    
    return 0;
}
