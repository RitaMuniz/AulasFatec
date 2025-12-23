#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	int id;
	
	printf("Digite sua idade: ");
	scanf("%d", &id);
	
	if(id<=18) printf ("Voce tem %d anos e eh menor de idade", id);
	else printf("Voce tem %d anos e eh maior de idade", id);
	
	return 0;
}
