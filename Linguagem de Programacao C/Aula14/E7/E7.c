#include <stdio.h>
#include <stdlib.h>

/**/

int main(int argc, char *argv[]) {
	
	double vet[100];
	
	FILE *arq;
	
	int res;
	int i;
	
	arq=fopen("ArqTest.dat", "rb");
	
	if (arq == NULL)
	{
		printf("Problemas na abertura do arquivo\n");
		return;
	}
	res= fread(&vet[0], sizeof(double), 100, arq);
	printf("Nro de elementos lidos: %d", res);
	
	for(i=0;i<res; i++)
	{
		printf("%f\n", vet[i]);
	}
	
	fclose(arq);
	return 0;
}
