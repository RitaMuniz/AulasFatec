#include <stdio.h>
#include <stdlib.h>

	/*	
	Atividade
	Rita de Cássia Muniz de Lima
	
	Ler arquivo que contem nome e nascimento, leia data de hoje e gere arquivo com nome e idade
	*/

struct DataCorrida																//struct para data
{
	int d, m, a;																//var para dia, mês e ano
}data;

struct DataNiver																//struct para data de aniversario
{
	int d, m, a;																//var para dia, mês e ano
}niver;

int retornaidade(struct DataCorrida data, struct DataNiver niver);				//função para retornar idade das structs

int main(int argc, char *argv[]) {
	
	char nome[20];
	
	FILE *nomeniver = fopen("Aniversário.txt", "r");							//aponta para arquivo para leitura
	
	if(nomeniver == NULL)														//Condição caso arquivo seja nulo
	{
		perror("Error: ");														//Mensagem de erro
		exit(1);
	}
	
	FILE *nomeidade = fopen("Idade.txt", "w");									//aponta para arquivo para escrita
	
	if(nomeidade == NULL)														//Condição caso arquivo seja nulo
	{
		perror("Error: ");														//Mensagem de erro
		exit(1);
	}
	
	printf("Digite a data de hoje dd/mm/aaaa: ");								//Pede para digitar data de hoje
	scanf("%d/%d/%d", &data.d, &data.m, &data.a);								//lê data
	
	int id;																		//var para idade
    while (fscanf(nomeniver, "%s %d/%d/%d", nome, &niver.d, &niver.m, &niver.a) == 4) {
        id = retornaidade(data, niver); 										// Calcula a idade
        fprintf(nomeidade, "%s %d\n", nome, id);								// Escreve no arquivo
    }
	
	fclose(nomeniver);															//Fecha arquivo
	nomeniver = NULL;															//Anula arquivo da var
	fclose(nomeidade);															//Fecha arquivo
	nomeidade = NULL;															//Anula arquivo da var
	
	return 0;
}

int retornaidade(struct DataCorrida data, struct DataNiver niver)				//função para retornar idade das structs
{
	int id = (data.a - niver.a);												//var para idade subtraindo o ano atual pelo ano do aniversario
	
	if(data.m < niver.m)														//Se Mês atual ser menor que mês de aniversário
	{
		return --id;															//diminui idade em 1 ano e retorna
	} 
	else if (data.m > niver.m)													//Se Mês atual for maior que o de aniversário
	{
		return id;																//retorna idade
	}
	else if(data.m == niver.m)													//Se mês atual for igual a mês de aniversário
	{
		if(data.d < niver.d)													//Se dia atual ser menor que dia de aniversário
		{
			return --id;														//diminui idade em 1 ano e retorna
		} 
		else if (data.d > niver.d)												//Se dia atual for maior que o de aniversário
		{
			return ++id;														//adiciona mais um a idade e retorna
		}
		else if(data.d == niver.d)												//se dia atual e de aniversario dor o mesmo
		{
			return id;															//retorna idade
		}
	}
	
}
