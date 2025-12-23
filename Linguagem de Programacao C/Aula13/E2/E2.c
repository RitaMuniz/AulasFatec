#include <stdio.h>
#include <stdlib.h>

/*Função Multiplica Prototipada*/

int multiplica (int n1, int n2);				//Função prototipada, ou seja, declaramos antes e escrevemos no final

int main(int argc, char *argv[]) {				//abertura da main
	
	int v1, v2, res;
	
	printf("Multiplicacao de 2 valores\n");
	printf("Digite o primeiro valor: ");
	scanf("%d", &v1);
	printf("Digite o segundo valor: ");
	scanf("%d", &v2);
	
	res= multiplica(v1,v2);						//chamamento da função utilizabdo os valores v1 e v2 em n1 e n2
	
	printf("Resultado= %d\n", res);				//resultado
	
	return 0;
}

int multiplica (int n1, int n2)					//Abertura da função
{
	int res;
	res= n1*n2;
	return(res);								//valor a ser retornado
}
