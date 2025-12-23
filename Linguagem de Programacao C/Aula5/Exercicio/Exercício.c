#include <stdio.h>
#include <stdlib.h>

int main() {
	
	/*Variáveis
	x= tamanho_vetor*/
	
	int v[50], i, x;
	
	//Ler tamanho do vetor
	printf("Defina o tamanho do vetor (entre 1 e 50): ");
	scanf("%d", &x);
	
	
	//Ler numeros do vetor
	for(i=0; i<x;i++){
		printf("Numero a adicionar ao vetor: ");
		scanf("%d", &v[i]);
	}
	
	//Imprimir numeros do vetor
	for(i=0; i<x; i++){
		printf("Numeros[%d]= %d \n", i, v[i]);
	}
	
	
	return 0;
}
