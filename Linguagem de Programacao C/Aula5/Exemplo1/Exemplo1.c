#include <stdio.h>
#include <stdlib.h>

int main() {
	
	//Definição Array
	int n[5];
	
	int i=0;
	
	for (i=0; i<5; i++) {
		printf("numero: ");
		scanf("%d", &n[i]);
		
		}
	
	//Imprime
	for (i=0; i<5; i++) {
		printf("numeros[%d] = %d \n", i, n[i]);
	}
	
	return 0;
}
