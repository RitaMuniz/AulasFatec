#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
	
	int vetor[10];
	int i=0;
	
	for(i=0; i<=9; i++) {
		vetor[i]= i;
	}

	
	for(i=0; i<=9; i++){
		printf("\n %d", vetor[i]);
	}
	
	
	return 0;
}
