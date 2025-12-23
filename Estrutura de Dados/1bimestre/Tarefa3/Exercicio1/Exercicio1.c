#include<stdio.h>
#include "pilha.h"

//Rita de Cassia Muniz de Lima
//Exercicio 1: Ordenação crescente

int main (void) {
	
	//Variaveis
	int n;										//Numero de valores da pilha
	int m;										//Variavel para usuario inserir os valores
	int i;										//Variavel para loop for
	
	//Pedindo ao usuario a qtde de valores que irá empilhar
	printf("Organizador em ordem crescente\n");
	printf("Digite a quantidade de valores que ira inserir: ");
	scanf("%d", &n);
	
	//Criação das pilhas do tamanho que usuario precisa
	Pilha A = pilha(n);
	Pilha B = pilha(n);
	
	for(i=0; i<n; i++) {
		
		//Valores do usuario
		printf("Valor %d: ", i+1);
		scanf("%d", &m);
		
		//Se pilha A não estiver vazia
		if(!vaziap(A)) {
		
			if(m > topo(A)) { 						//Se m for maior que numero que esta no topo da pilha
				while(!vaziap(A) && m > topo(A)) {	//enquanto o topo da pilha for menor que m
					empilha(topo(A), B);			//Empilha o topo de A em B
					desempilha(A);					//Tira o valor de A
				}
				
				empilha(m, A);						//Coloca m no topo da pilha
			
				while(!vaziap(B)) {
					empilha(topo(B), A); 			//Empilha de volta em A
					desempilha(B); 					//Tira de B
				}	
			}
		
			else{									//Se m for menor que numero que esta no topo da pilha
				empilha(m, A);						//Empilha normalmente
			}
		}
		else {										//Se a pilha estiver vazia
			empilha(m, A);							//empilha normalmente
		}
	}
	
	//Retorno ao usuario
	printf("\nEm ordem crescente: ");
	
	//Desempilhando os itens da pilha
	while(!vaziap(A)) {
		printf("%d ", desempilha(A));
	}
	
	destroip(&A);
	destroip(&B);
	
	return 0;
}
