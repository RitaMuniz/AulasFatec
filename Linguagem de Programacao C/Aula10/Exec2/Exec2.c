#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
	int *p, *p1, x=10;										 //variavel x recebe 10
	float y = 20.0;											 //variavel y recebe 20.0
	
	p= &x;													 //variavel p recebe valor de x, logo p=10
	printf("\n Conteudo apontado por p: %d", *p);			 //será imprimido valor de p, que é 10
	
	p1=p;													 //variavel p1 recebe valor de p, logo p1=10
	printf("\n Conteudo apontado por p1:%d", *p1);			 //será imprimido valor de p1, que é 10
	
	p=&y; //p recebe valor de y, logo p=20.0
	printf("\n Conteudo apontado por p: %d", *p);			 //não é capaz de imprimir 20, pois chama var decimal, y é float e p é int
	printf("\n Conteudo apontado por p: %f",*p);			 //não é capaz de imprimir 20.0, pois y é float e p é int, mas vai imprimir zerado
	printf("\n Conteudo apontado por p: %f",*((float*)p));	 //Vai imprimir valor de p, que é 20.0
	
	return 0;
}
