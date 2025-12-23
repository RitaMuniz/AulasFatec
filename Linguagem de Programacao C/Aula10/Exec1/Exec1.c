#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
	
	int var1=100;
	int *ptr1;
	
	ptr1= &var1;
	
	printf("\n Conteudo apontado por ptr1: %d", *ptr1);
	printf("\n Conteudo apontado por ptr1: %d", ptr1);
	printf("\n Conteudo apontado por ptr1: %x", ptr1);
	printf("\n Conteudo apontado por ptr1: %d", &var1);
	printf("\n Conteudo apontado por ptr1: %d", var1);
	
	return 0;
}
