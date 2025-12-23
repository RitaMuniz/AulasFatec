#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(void) {
	

	char c;
	
	printf("caracter: ");
	scanf("%c", &c);
	
	printf("ASCII em octal= %o \n", c);
	printf("ASCII em decimal= %d \n", c);
	printf("ASCII em Hexadecimal= %X \n", c);

	return 0;
}
