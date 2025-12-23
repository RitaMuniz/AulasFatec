#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	//Codigo que calcula o perímetro de uma circunferencia
	
	float r, p; //r=raio; p=perimetro
	
	printf("Digite o raio: ");
	scanf("%f", &r);
	
	p=2*3.14*r; //calculo
	
	printf("Perimetro= %f", p);

	return 0;
}
