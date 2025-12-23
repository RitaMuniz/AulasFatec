#include<stdio.h>

//Rita de Cassia Muniz de Lima
//Exemplo 4: Fatorial

int main(void) {
	//Variaveis
	int n, f;
	
	//Usuario
	printf("Fatorial\n");
	printf("Digite um numero: ");
	scanf("%d", &n);
	
	//calculo
	f=1;
	int i=0;
	for(i=2; i<=n; i++) {
		f *= i;
	}
	
	//Resposta
	printf("Fatorial: %d\n", f);
	
	return 0;
}
