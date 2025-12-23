#include<stdio.h>

//Rita de Cassia Muniz de Lima
//Exemplo 11: Funcionamento

int main(void) {
    int v;		//Variavel
    int *p;		//ponteiro
    
    printf("Funcionamento de um ponteiro");
    printf("\nDigite um numero: ");
    scanf("%d", &v);
    
    p= &v;			// p recebe endereco da variavel
    *p = *p + 2;	//ponteiro p aponta para o endereco dentro dele, que recebe o valor da variavel e adiciona + 2
    
	printf("\n\nv = %d, *p = %d\n", v, *p); //imprime o valor dentro da variavel, imprime o valor armazenado na variavel apontada
    
    return 0;

}
