#include <stdio.h>
#include <stdlib.h>

/**/

int main(int argc, char *argv[]) {
	
	FILE *pont_arq;
	char c;
	pont_arq = fopen("Arquivo1.txt", "r");
	
	//abrir arquivo para leitura
	if(pont_arq == NULL)
	{
		printf("\nErro abrir o arquivo\n");
		exit(1);
	}
	printf("\nLendo e exibindo\n");
	
	do
	{
		c= fgetc(pont_arq);
		printf("%c", c);
	} while(c != EOF);
	
	fclose(pont_arq);
		
	return 0;
}
