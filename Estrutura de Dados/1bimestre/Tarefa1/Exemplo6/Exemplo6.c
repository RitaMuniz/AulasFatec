#include<stdio.h>
#include<time.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exemplo 6: Adivinhação

int main(void) {
	//Variaveis
	srand(time(NULL));
	int c;
	int n = rand() % 7 + 1;
	
	//Usuario
	printf("Adivinhe o numero\n");
	
	do{
		printf("Chute entre 1 e 7: ");
		scanf("%d", &c);
		
		if(c<n) puts("\nBaixo!\n");
		else if(c>n) puts("\nAlto!\n");
	} while( c != n);
	
	puts("\nAcertou!\n");
	
	return 0;
}

