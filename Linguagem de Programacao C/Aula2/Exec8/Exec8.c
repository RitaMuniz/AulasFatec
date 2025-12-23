#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	float km, l, cm;
	
	printf("Digite km percorridos: ");
	scanf("%f", &km);
	
	printf("Digite l gastos no percurso: ");
	scanf("%f", &l);
	
	cm=km/l;
	
	printf("km percorridos= %f.1", km);
	printf("litros gastos= %f.1", l);
	printf("consumo medio= %f.1 km/l", cm);
	
	
	return 0;
}
