#include <stdio.h>
#include <stdlib.h>

/**/

void SOM(float a, int b)										//Abertura função
{
	float r;
	r=a+b;
	printf("A  soma de %6.3f com %d e %6.3f\n", a, b, r);
}

int main(int argc, char *argv[]) {
	
	int a;
	float b;
	a=10;
	b=12.3;
	SOM(b,a);													//chamando função
		
	return 0;
}
