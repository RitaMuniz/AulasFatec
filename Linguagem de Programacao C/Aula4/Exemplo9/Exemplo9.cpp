#include <stdio.h>
#include <stdlib.h>


int main(void) {
	
	int n;
	
	printf("Numero: ");
	scanf("%d", &n);
	
	while(n>0) {
		printf("%d \n", n%10); //Começa a mostrar cada digito do numero digitado
		n/=10; //significa n=n/10 
	}
	
	return 0;
	}
