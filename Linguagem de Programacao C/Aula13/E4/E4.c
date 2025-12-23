#include <stdio.h>
#include <stdlib.h>

/*Função de soma*/

float soma(float a, float b)				//abertura função
{
	return a+b;								//retorna fazendo a operação direto 
}

int main(int argc, char *argv[]) {
	
	float n1, n2;
	
	printf("Digite um valor: ");
	scanf("%f", &n1);
	printf("Digite outro valor: ");
	scanf("%f", &n2);
	
	printf("Soma: %f \n", soma(n1,n2));		//chama a função já na impressão
	
	return 0;
}
