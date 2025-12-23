#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

	float tt, l, p, desc;
	
	printf("Quantos litros de gasolina foram colocados?: ");
	scanf("%f", &l);
	
	printf("Qual eh o preco do litro?: ");
	scanf("%f", &p);

	tt= l*p;
	
	if(tt>100.00) {
		desc= tt*0.05;
		printf("Desconto: R$ %.2f \n", desc);
		tt=tt-desc;
		
	}
	
	printf("Total: R$ %.2f \n", tt);
	
	return 0;
}
