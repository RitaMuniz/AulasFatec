#include<stdio.h>

//Rita de Cassia Muniz de Lima
//Exemplo 5: Soma dos digitos

int main(void) {
	
	//Variaveis
	int n;
	
	//Usuario
	printf("Soma dos digitos\n");
	printf("Digite um numero: ");
	scanf("%d", &n);
	
	//Calculo
	int s=0;
	while(n>0) {
		s += n%10;
		n /= 10;
	}
	printf("Soma dos digitos = %d\n", s);
	
	return 0;
} 
