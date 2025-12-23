#include <stdio.h>
#include <stdlib.h>

/*Função Multiplica Prototipada e sem retorno*/

void imprime_cabec(void);						//Função prototipada, ou seja, declaramos antes e escrevemos no final
int multiplica (int n1, int n2);				//Função prototipada, ou seja, declaramos antes e escrevemos no final

int main(int argc, char *argv[]) {				//abertura da main
	
	int v1=0, v2=0, res=0;
	
	imprime_cabec();							//chama função
	
	printf("\nMultiplicacao de 2 valores\n");
	printf("Digite o primeiro valor: ");
	scanf("%d", &v1);
	printf("Digite o segundo valor: ");
	scanf("%d", &v2);
	
	res= multiplica(v1,v2);						//chamamento da função utilizabdo os valores v1 e v2 em n1 e n2
	
	printf("Resultado= %d\n", res);				//resultado
	
	return 0;
}

void imprime_cabec(void)						//Abertura da função void
{
	printf("*****************************");	
	printf("\n * LINGUAGEM C * \n");
	printf("*****************************");
	
	return;										//retorno de uma função void
}

int multiplica (int n1, int n2)					//Abertura da função
{
	int res;
	res= n1*n2;
	return(res);								//valor a ser retornado
}
