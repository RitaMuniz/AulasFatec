#include <stdio.h>
#include <stdlib.h>

/*Funçao prototipada e sem retorno*/

void alo(void);							//declarção de função prototipada

int main(int argc, char *argv[]) 
{
	
	int i;
	i=1;
	
	while (i<=3)						//enquanto i for menor ou igual a 3
	{
		alo();							//chamando função alo
		i+=1;
	}
	
	return 0;
}

void alo(void)							//abertura função alo
{
	printf("Alo!\n");
}
