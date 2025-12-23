#include<stdio.h>

//Rita de Cassia Muniz de Lima
//Exemplo 10: Ponto

//Cração de registro
typedef struct {
	float x;
	float y;
}Ponto;

int main (void) {
	//Variaveis
	Ponto p = {1.5, 2.5}; //Chama o registro e atribui infos as variaveis
	
	//Impressão
	printf("(%.1f, %.1f)\n", p.x, p.y); 
	
	return 0;
}
