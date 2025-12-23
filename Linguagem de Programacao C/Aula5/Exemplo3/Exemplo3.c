#include <stdio.h>
#include <stdlib.h>

int main() {
	
	//Definição array e var
	const char *f[3]={"Maca", "Banana", "Laranja"};
	int i;
	
	//Imprime
	for(i=0; i<3; i++){
		printf("Frutas[%d]= %s \n", i, f[i]);
	}
		
	
	}
