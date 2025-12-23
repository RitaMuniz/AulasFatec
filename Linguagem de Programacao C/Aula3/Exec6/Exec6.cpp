#include <stdio.h>
#include <stdlib.h>


int main(void) {
	
	float p1, p2, m;
	int f;
	
	printf("Digite a notas 1: ");
	scanf("%f",&p1 );

	printf("Digite a notas 2: ");
	scanf("%f",&p2 );
	
	printf("Digite a quantidade de faltas: ");
	scanf("%d",&f );
		
	m=(p1+p2)/2;
	
	if(m>=6 & f<=5) printf ("Sua media eh %.2f e voce tem %d faltas. Esta aprovado!", m, f);
	else printf ("Sua media eh %.2f e voce tem %d faltas. Esta reprovado", m, f);
	
	
	return 0;
}
