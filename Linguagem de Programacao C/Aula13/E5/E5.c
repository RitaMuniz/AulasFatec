#include <stdio.h>
#include <stdlib.h>

/*Função quadrado d x*/

int quadrado(int x)											 	//abertura função
{
	return x*x;													//retorna fazendo a operação direto 
}

int main(int argc, char *argv[]) {
	
	int n;
	
	printf("Digite um numero: ");
	scanf("%d", &n);
	
	printf("O quadrado do numero eh: %d \n", quadrado(n));		//chama a função já na impressão
	
	return 0;
}
