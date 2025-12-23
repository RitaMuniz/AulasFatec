#include <stdio.h>
#include <stdlib.h>

/**/

int main(int argc, char *argv[]) {
	int x, *ptrx, **pptrx;
	
	x=0;
	
	printf("\n Valor de x= %d ", x);
	printf("\n Enderecp de x: %x ", &x);
	
	//atribuindo enderecos p/ ponteiros
	ptrx= &x;
	pptrx= &ptrx;
	
	*ptrx= *ptrx + 10;
	printf("\n Valor de x= %d ", x);
	printf("\n Endereco apontado por ptrx= %x ", ptrx);
	printf("\n Valor da variavel x que esta sendo apontada por ptrx= %d ", *ptrx);
	printf("\n Endereco de memoria da variavel ptrx= %x ", &ptrx);
	
	**pptrx = **pptrx + 10;
	printf("\n Valor de x= %d ", x);
	printf("\n Endereco apontado por **pptrx= %x ", pptrx);
	printf("\n Valor da variavel para a qual pptrx faz referencia: %d ", **pptrx);
	printf("\n Endereco de memoria da variavel **pptrx= %x ", &pptrx);
	
	
	return 0;
} 
