#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exemplo 15: Uma lista de numeros

typedef struct no *Ptr; //Desclara no como ponteiro
//Funcao que fará um nó
struct no {
	int item;			//Variavel item
	Ptr prox;			//Ponteiro prox
};

//ponteiro no
Ptr no (int x, Ptr p) {
	Ptr n = malloc(sizeof(struct no));
	
	n->item = x;		//Variavel que armazenara o no
	n->prox = p;		//ponteiro que apontará nó
	
	return n;
}

//Funcao principal
int main (void) {
	//Listando nmeros do nó
	Ptr p = no(3, no(1, no(5, NULL)));
	
	//loop para mostrar conteudo do nó
	while( p != NULL) {
		printf("Valor: %d\n", p->item);
		p = p->prox;
	}
	
	return 0;
}
