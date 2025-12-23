#include <stdio.h>
#include <stdlib.h>

/**/

int main(int argc, char *argv[]) {
	
	int *p1;													//ponteiro p1 declarado inteiro
	int i=0;													//var declarada como inteira e atribuido valor 0
	int vetor[]= {10, 2, 89, 32, 24, 5, 86, 11, 33, 100};		//vetor com valores inseridos e declarado como inteiro
	
	for(i=0; i<10; i++){
		
		p1= &vetor[i];											//apontando p1 para o vetor
		
		printf("Valor no vetor %d : %d \n", i, *p1);			//imprimindo valores do vetor
	}
	
	for(i=0; i<10; i++){										//iteração para passar por cada lugar do vetor
		
		p1= &vetor[i];											//apontando p1 para o vetor
		
		if(*p1%2==0) {											//repetição SE para identificar se vetor é par
			printf("Vetor %d possui um valor par.\n", i);		//impressão identificando vetor par
		}
	}
	
	return 0;													//retorna 0 para finaizar
}
