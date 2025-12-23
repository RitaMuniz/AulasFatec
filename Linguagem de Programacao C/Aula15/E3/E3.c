#include <stdio.h>
#include <stdlib.h>

/*
	Atividade
	Rita de Cássia Muniz de Lima
	
	Ler arquivo. Lista de compra com produto, quant e valor. Retorna valor total
	*/

int main(int argc, char *argv[]) {
	/*Lista (NomeDoProduto QuantidadeDoProduto ValorUnitarioDoProduto: 
	Banana 6 1.99
	Laranja 10 2.90
	Pera 5 2.00
	Uva 1 7.00
	Caju 3 4.00*/
	
	char prod[20];													//Var p/ produtos
	int quantprod;													//var p/ quantidade dos produtos
	float valprod, valor = 0.0;										//var para valor e valor total
	
	FILE *listcompra = fopen("Produto2.txt", "r");					//abre o arquivo
	
	if(listcompra == NULL)											//Condição caso arquivo seja nulo
	{
		perror("Error: ");											//Mensagem de erro
		exit(1);
	}
	
	while(!feof(listcompra))										//Condição para leitura do arquivo
	{
		fscanf(listcompra, "%s %d %f", prod, &quantprod, &valprod);	//leitura e inserção nas variaveis
		valor += ((float)quantprod * valprod); 						//Calculo para valor total
	}
	
	printf("O valor total da lista e de: R$%.2f\n", valor);			//Retorno
	
	fclose(listcompra);												//Fecha arquivo
	listcompra = NULL;												//Anula arquivo da var
	
	return 0;
}
