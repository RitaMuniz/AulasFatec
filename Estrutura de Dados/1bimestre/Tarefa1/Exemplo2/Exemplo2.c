#include<stdio.h>
#include<math.h>

//Rita de Cassia Muniz de Lima
//Exemplo 2: Indice de Massa Corporal (2 versão)

int main(void) {
	
	//Variaveis
	float p, a, i;
	
	//Para o Usuario
	printf("IMC");
	printf("\nPeso: ");
	scanf("%f", &p);
	printf("Altura: ");
	scanf("%f", &a);
	
	//Calculo
	i=p/pow(a,2);
	
	//Condicional para resposta
	if(i<18.5) puts("\nAbaixo do peso");
	else if(i>30) puts("\nAcima do peso");
	else puts("\nNo peso ideal");
	
	return 0;
}
