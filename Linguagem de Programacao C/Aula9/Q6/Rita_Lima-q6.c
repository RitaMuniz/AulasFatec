#include <stdio.h>
#include <stdlib.h>

//Rita de Cássia Muniz de Lima
//Exercício 6: iteração while

int main(void) {
	
	int i, x, y;
	
	while(i<5) {
		i++;
		
		printf("\ni = %d ", i);
		if(i%2) {
			x = i-2;
			printf("\nx = %d", x);
		}
		else {
			y = i+3;
			printf("\ny = %d", y);
		}
	}
	return 0;
}



