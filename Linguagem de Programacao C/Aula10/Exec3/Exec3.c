#include <stdio.h>
#include <stdlib.h>

/**/

int main(int argc, char *argv[]) {
	
	int n1=1,
		n2=2;
		
	char l1=1,
		 l2=2;
		 
	printf("n1: \n");
	printf("Valor: %d\n", n1);
	printf("Endereco na memoria: %d \n\n", &n1);
	
	printf("n2: \n");
	printf("Valor: %d\n", n2);
	printf("Endereco na memoria: %d \n\n", &n2);
	
	printf("l1: \n");
	printf("Valor: %c\n", l1);
	printf("Endereco na memoria: %d \n\n", &l1);
	
	printf("l2: \n");
	printf("Valor: %c\n", l2);
	printf("Endereco na memoria: %d \n\n", &l2);
	
	n1=2112;
	n2=666;
	l1='A';
	l2='B';
	
	printf("n1: \n");
	printf("Valor: %d\n", n1);
	printf("Endereco na memoria: %d \n\n", &n1);
	
	printf("n2: \n");
	printf("Valor: %d\n", n2);
	printf("Endereco na memoria: %d \n\n", &n2);
	
	printf("l1: \n");
	printf("Valor: %c\n", l1);
	printf("Endereco na memoria: %d \n\n", &l1);
	
	printf("l2: \n");
	printf("Valor: %c\n", l2);
	printf("Endereco na memoria: %d \n\n", &l2);
		
	return 0;
}
