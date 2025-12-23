#include <stdio.h>
#include <stdlib.h>


int main(void) {
	
	int x=5, y, z;
	
	//y= ++x +2; //Como os sinais vem antes, fica 6+2=8
	//z= x-- +2; //Como o sinais estão depois, a operação do x é feita depois, fica 6+2=8 (6 pq antes somou)
	
	y= x++ +2; //Como o sinais estão depois, a operação do x é feita depois, fica 5+2=7 (6 pq antes somou)
	z= --x + 2; //Como os sinais vem antes, fica 5+2=7
	
	
	printf("x= %d, y= %d, z= %d \n", x, y, z);
	
	return 0;
}
