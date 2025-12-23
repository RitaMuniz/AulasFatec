#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	//consumo médio de combustivel por km
	
	float km, l, cm;
	
	printf("Digite km percorridos: ");
	scanf("%f", &km);
	
	printf("Digite l gastos no percurso: ");
	scanf("%f", &l);
	
	cm=km/l;
	
	printf("\n km percorridos= %.1f", km);
	printf("\n litros gastos= %.1f", l);
	printf("\n consumo medio= %.1f km/l", cm);
	
	
	return 0;
}
