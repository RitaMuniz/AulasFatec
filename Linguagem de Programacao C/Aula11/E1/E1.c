#include <stdio.h>
#include <stdlib.h>

/**/

int main(int argc, char *argv[]) {
	
	int in=4;
	int *in_ptr=4;
	
	printf("Valor  da variavel'in': %d\n", in);
	printf("Endereco da variavel 'in': %d\n", &in);
	printf("Valor armazenado no ponteiro 'in_ptr': %d\n", in_ptr);
	printf("Endereco armazenado no ponteiro 'in_ptr': %d", &in_ptr);
	
	printf("\n\nApos o uso dos ponteiros, vamos apontar para NULL \n\n");
	in= NULL;
	in_ptr= NULL;
	
	printf("Endereco da variavel 'in': %d\n", &in);
	printf("Endereco armazenado no ponteiro 'in_ptr': %d", &in_ptr);
	
	return 0;
}
