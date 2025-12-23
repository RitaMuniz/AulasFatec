#include <stdio.h>						//biblioteca
#include <stdlib.h>						//biblioteca

/*Exercício de ponteiros*/

int main(void) {		//abertura da main
	
	int vetor[]={10, 20, 30, 40, 50};	//vetor declarado como inteiro e atribuído valores
	
	int *p1, *p2;						//variavel ponteiro p1 e p2 declarados como inteiros
	int i=100;							//variaval i declarada como inteira e recebe valor 100
	
	p1 = &vetor[2];						//p1 recebe valor de vetor 2
	
	printf("Valor de p1: %d\n", *p1);	//imprime valor de p1
	
	p2=&i;								//p2 recebe valor de i
	
	printf("Valor de p2: %d\n", *p2);	//Imprime valor de p2
	
	p2=p1;								//p2 recebe valor de p1
	
	printf("Valor de p2: %d\n", *p2);	//imprime valor de p2
	
	return 0;							//retorna zero
}										//fechamento da main
