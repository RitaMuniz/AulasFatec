#include<stdio.h>
#include<math.h>

//Rita de Cassia Muniz de Lima
//Exemplo 1: Indice de massa corporal

int main (void) {
	
	//Variaveis
	float p, a, i;
	
	//Perguntas ao Usuario
	printf("IMC");
	printf("\nPeso: ");
	scanf("%f", &p);
	printf("\nAltura: ");
	scanf("%f", &a);
	
	//Calculo
	i=p/pow(a,2);
	
	//Resposta
	printf("IMC= %.2f", i);
	return 0;
}
