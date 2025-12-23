#include <stdio.h>
#include <stdlib.h>

/*NUMERO POSITIVO OU NEGATIVO*/

int posneg(int a)
{
	if(a>=0)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

int main(int argc, char *argv[]) {
	
	int n=0;
	
	printf("Se valor for positivo, retornara 1. Se negativo, retornara 0");
	printf("\nDigite um valor:");
	scanf("%d", &n);
	
	n=posneg(n);
	
	printf("\nValor retornado: %d ", n);
	
	return 0;
}
