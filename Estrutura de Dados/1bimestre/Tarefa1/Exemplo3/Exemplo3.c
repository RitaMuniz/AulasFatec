#include<stdio.h>

//Rita de Cassia Muniz de Lima 
//Exemplo 3: Rodízio de veículos

int main (void) {
	
	//Variaveis
	int p;
	
	//Usuario
	printf("Rodizio de placas\n");
	printf("Digite os 4 ultimos digitos da placa: ");
	scanf("%d", &p);
	
	switch(p%10) {
		case 1: case 2: puts("\nSegunda"); break;
		case 3: case 4: puts("\nTerca");   break;
		case 5: case 6: puts("\nQuarta");  break;
		case 7: case 8: puts("\nQuinta");  break;
		default:		puts("\nSexta");
	}
	
	return 0;
}
