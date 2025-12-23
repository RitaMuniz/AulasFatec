#include<stdio.h>
#include "pilha.h"

// Rita de Cassia Muniz de Lima
// Exercicio 2: Ordenação decrescente sem repetição

int existe(Itemp m, Pilha A) {
    Pilha temp = pilha(A->max); // Pilha temp
    int existe = 0;
    
    while(!vaziap(A)) {
        if (topo(A) == m) {
            existe = 1; 
            break;
        }
        empilha(desempilha(A), temp); // Empilha os elementos em temp
    }
    
    // Volta os elementos para a pilha original
    while(!vaziap(temp)) {
        empilha(desempilha(temp), A);
    }

    destroip(&temp);
    return existe;
}

int main (void) {
    // Variaveis
    int n; // Numero de valores da pilha
    int m; // Variavel para inserir os valores
    int i; // Variavel para loop for

    // Pedindo ao usuario a qtde de valores que irá empilhar
    printf("Organizador em ordem decrescente sem repeticao\n");
    printf("Digite a quantidade de valores que ira inserir: ");
    scanf("%d", &n);

    // Criação das pilhas do tamanho que usuario precisa
    Pilha A = pilha(n);
    Pilha B = pilha(n);

    for(i = 0; i < n; i++) {
        // Valores do usuario
        printf("Valor %d: ", i + 1);
        scanf("%d", &m);

        // Verifica se o valor já existe na pilha (sem repetição)
        if (!existe(m, A)) {
            // Se pilha A não estiver vazia
            if (!vaziap(A)) {
                if (m < topo(A)) { // Se m for menor que o número que está no topo da pilha
                    while (!vaziap(A) && m < topo(A)) { // Enquanto o topo da pilha for maior que m
                        empilha(topo(A), B); // Empilha o topo de A em B
                        desempilha(A); // Tira o valor de A
                    }

                    empilha(m, A); // Coloca m no topo da pilha

                    while (!vaziap(B)) {
                        empilha(topo(B), A); // Empilha de volta em A
                        desempilha(B); // Tira de B
                    }
                } 
				else { // Se m for maior ou igual ao topo da pilha
                    empilha(m, A); // Empilha normalmente
                }
            } 
			else { // Se a pilha estiver vazia
                empilha(m, A); // Empilha normalmente
            }
        } 
		else {
            printf("Repetido\n");
        }
    }

    // Retorno ao usuario
    printf("\nEm ordem decrescente: ");
    
    // Desempilhando os itens da pilha
    while (!vaziap(A)) {
        printf("%d ", desempilha(A));
    }

    destroip(&A);
    destroip(&B);

    return 0;
}

