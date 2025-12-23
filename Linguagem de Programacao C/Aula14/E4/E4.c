#include <stdio.h>
#include <stdlib.h>

/**/

void ZeraVet(float v[10], int qtd)
{
	int i;
	
	for(i=0; i<qtd; i++)
	{
		v[i]= 0.0;
	}
}
int main(int argc, char *argv[]) {
	
	int i;
	float vet[10];
	
	ZeraVet(vet, 10);
	
	for(i=0; i<10; i++);
	{
		printf("%d", vet[i]);
	}
	return 0;
}
