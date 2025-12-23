#include <stdio.h>
#include <stdlib.h>

/*Numero maior*/

int maior(int a, int b)
{
	if(a>b)
	{
		return a;
	}
	else if(b>a)
	{
		return b;
	} 
	else
	{
		return 0;
	}
}

int main(int argc, char *argv[]) {
	
	int n=0, m=0, p=0;
	
	printf("Digite dois valores e sera retornado o maior deles. Se ambos forem iguais, retornara 0\n");
	printf("Digite primeiro valor: ");
	scanf("%d", &n);
	printf("Digite outro valor: ");
	scanf("%d", &m);
	
	p= maior(n,m);
	
	printf("Valor retornado: %d", p);
	
	return 0;
}
