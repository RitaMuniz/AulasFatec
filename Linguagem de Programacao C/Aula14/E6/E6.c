#include <stdio.h>
#include <stdlib.h>

/*Criação arquiva*/

int main(int argc, char *argv[]) {
	
	double notas[100];
	
	FILE *arq;
	
	int res;
	int i;
	
	arq=fopen("ArqTest.dat", "wb");						//criação do arquivo para leitura e edição
	
	if (arq == NULL)
	{
		printf("Problemas na criacao do arquivo\n");
		return;
	}
	res= fwrite(&notas[50], sizeof(double), 30, arq);	//escrever no arquivo
	printf("Nro de elementos gravados: %d", res);
	fclose(arq);
	return 0;
}
