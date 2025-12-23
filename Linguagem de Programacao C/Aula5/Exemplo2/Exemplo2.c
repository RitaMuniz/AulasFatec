#include <stdio.h>
#include <stdlib.h>

int main() {
	
	//Definição Array e var
	float t[4]= {23, 5, 24, 0, 22, 8, 25, 1};
	int i;
	
	//Imprime
	for(i=0; i<4; i++) {
		printf("temperatura[%d]= %.1f \n", i, t[i]);
	}
	
	return 0;
}
