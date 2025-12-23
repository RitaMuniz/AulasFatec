#include <stdio.h>

//Rita de Cássia Muniz de Lima
//Exercício 7: Livro de receitas

struct livroReceitas {
	
    char nome[25];
    int quantIngredientes;
    char ingredientes[10][30];
};

int main(void) {
	
    struct livroReceitas livro[5];
    
    printf("Livro de Receitas \n");

	int i=0;
	int j=0;
    for (i = 0; i < 5; i++) { 
        printf("Receita %d : \n", i + 1);
        
        printf("Digite o nome da receita: ");
        fgets(livro[i].nome, 25, stdin);
        
        printf("Digite a quantidade de ingredientes da receita: ");
        scanf("%d", &livro[i].quantIngredientes);
        getchar();
    
        for (j = 0; j < livro[i].quantIngredientes; j++) {
            printf("%dº ingrediente: ", j + 1);
            fgets(livro[i].ingredientes[j], 30, stdin);
        }
    }
    
    char pesquisa[25]; 
    do {
        printf("Digite o nome da receita que procura: ");
        fgets(pesquisa, 25, stdin);
        
        if (pesquisa[0] == '\n') {
            break;
        }
        
        int encontrouReceita = 0;
        for (i = 0; i < 5; i++) {
            int j = 0;
            
            while (livro[i].nome[j] != '\0' && pesquisa[j] != '\0' && livro[i].nome[j] == pesquisa[j]) {
                j++;
            }
            
            if (livro[i].nome[j] == '\0' && (pesquisa[j] == '\n' || pesquisa[j] == '\0')) {
                encontrouReceita = 1;
                printf("\nReceita %d : \n", i + 1);
                printf("Nome da receita: %s", livro[i].nome);
                printf("Quantidade de ingredientes: %d\n", livro[i].quantIngredientes);
                
                for (j = 0; j < livro[i].quantIngredientes; j++) {
                    printf("%dº ingrediente: %s", j + 1, livro[i].ingredientes[j]);
                }
                break;
            }
        }
        
        if (!encontrouReceita) {
            printf("\nReceita não encontrada!\n");
        }
        
    } while (1);
    
    return 0;
}
                             
