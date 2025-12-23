#include <stdio.h>
#include <stdlib.h>

int main(void) {
	
	float a, b, c;
	printf("Digite valor 1:");
	scanf("%f", &a);

	printf("Digite valor 2:");
	scanf("%f", &b);
	
	printf("Digite valor 3:");
	scanf("%f", &c);	
	
	if(a<b+c && b<a+c &&c<a+b) {
		printf("Triangulo: ");
		
		if(a==b || b==c) puts ("Equilatero");
		else if (a==b || a==c || b==c) puts ("Isoceles");
		else puts ("Escaleno");
	}
	
	else puts("Não eh um triangulo");
	
	return 0;
}
