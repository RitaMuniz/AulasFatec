#include<stdio.h>

//Rita de Cassia Muniz de Lima
//Exemplo 7: A função fatorial

//Função fatorial
int fat (int n) {
	//Variaveis
	int f = 1;
	int i=0;
	
	//Calculo
	for(i=2; i<=n; i++) f *= i;
	return f; 
}

//Principal
int main (void) {
	//Variavel
	int n1;
	
	//Usuario
	printf("Fatorial\n");
	printf("Digite um numero: ");
	scanf("%d", &n1);
	printf("Fatorial de %d = %d", n1, fat(n1));
	
	return 0;
}
