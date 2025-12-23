#include <stdio.h>
#include <stdlib.h>
#include <time.h>  //biblioteca de tempo

int main(void) {
	
	srand(time(NULL)); //faz com que o número não se repita
	
	int c, n= rand()%7+1; 
	
	printf("\n jogo de adivinhacao \n ");
	

	
	do {
	
		printf("Escolha um numero entre 1 e 7: ");
		scanf("%d", &c);
		
		if(c>n) puts("Muito alto!");
		else if (c<n) puts("Muito baixo");
		else puts("ACERTOU!!!");
		
	}while(n!=c);
	
	return 0;
	}
