#include <stdio.h>
#include <stdlib.h>

//Media das notas
int main(void) { 
	
	float p1, p2, m;
	
	printf("Digite a notas 1: ");
	scanf("%f",&p1 );

	printf("Digite a notas 2: ");
	scanf("%f",&p2 );
		
	m=(p1+p2)/2;
	
	if(m>=6) puts ("Aprovado");
	else puts ("Reprovado");
	
	return 0; 
	
}
