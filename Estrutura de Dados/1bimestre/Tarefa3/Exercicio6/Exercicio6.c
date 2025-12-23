#include<stdio.h>
#include<string.h>
#include "pilha.h"

//Rita de Cassia Muniz de Lima
// Exercicio 6: Pilha de strings

int main (void) {
    Pilha P = pilha(5);      // Pilha com capacidade para 5 strings
    char s[11];              

    int i;
    for(i = 0; i < 3; i++) { // Lê 3 palavras
        printf("Palavras? ");
        gets(s);  
        
        // Cria uma cópia da string usando strdup
        char* copia = strdup(s);
        
        if (copia == NULL) {
            printf("Erro ao alocar memoria para a string.\n");
            return 1;  // Se strdup falhar, aborta o programa
        }

        empilha((Itemp)copia, P);  // Empilha a cópia da string
    }

    // Desempilhando as palavras e liberando memória
    while(!vaziap(P)) {
        // Desempilha a string
        char* palavra = (char*)desempilha(P);
        puts(palavra);                  // Imprime a palavra desempilhada
        free(palavra);                  // Libera a memória
    }

    destroip(&P);  // Libera a pilha
    
    return 0;
}

