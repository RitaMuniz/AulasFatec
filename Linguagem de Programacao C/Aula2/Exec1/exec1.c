#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <math.h>
#define LIMITE 30


/* run this program using the console pauser or add your own getch, system("pause") or input loop */


//MEDE O IMC DA PESSOA
int main(int argc, char *argv[]) {
	
	float p, a, imc;
	
	
	printf("\nQual o seu peso e altura? ");
	scanf("%f %f", &p, &a);
	imc=p/pow(a,2);
	printf("\n Seu i.m.c e %.1f ", imc);
	
	if(imc<= LIMITE)
		printf("\n Voce nao esta obeso!");
	else
		printf("\n Voce esta obeso!");
	getch();
	
	return 0;
}

