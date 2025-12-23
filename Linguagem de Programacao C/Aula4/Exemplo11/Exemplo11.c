#include <stdio.h>
#include <stdlib.h>


int main(void) {
	
	int s=0, n;
	
	do {
	
		printf("Numero: ");
		scanf("%d", &n);
		s+=n;
	}while(n!=0);
	
	printf("Soma = %d \n", s);  
	
	return 0;
	}
