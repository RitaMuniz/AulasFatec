#include <stdio.h>
#include <stdlib.h>

/**/

int main(int argc, char *argv[]) {
	
	int c;
	FILE *pa;
	char *nome = "Arquivo1.txt";
	
	//abrir arquivo para leitura
	if((pa = fopen(nome, "r")) == NULL)
	{
		printf("\nNao foi possivel abrir o arquivo\n");
		exit(1);
	}
	printf("\nImprimindo...\n");
	c= fgetc(pa);											//retorna arquivo ou fim dele
	
	while(!feof(pa))
	{
		putchar(c);
		c= fgetc(pa);
	}
	fclose(pa);
	getchar();												//espera usuario digitar algo
	
	return 0;
}
