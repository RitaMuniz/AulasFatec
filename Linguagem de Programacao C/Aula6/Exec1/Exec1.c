#include <stdio.h>
#include <stdlib.h>

	//Programa com estrutura de dados heterogeneos (struct)
		
	//Variaveis para nome do funcionario
	typedef struct nomeFunc
	{
		char nomef[30];					//primeiro nome
		char snome[30]; 				//sobrenome
	};
	
	//Variaveis para endereço do funcionario
	typedef struct endFunc
	{
		char rua[30];					//rua
		int num;						//numero da casa
		int cep;						//CEP
		char bairro[30];				//bairro
		char cid[30];					//cidade/municipio
		char es[2];						//estado
		char pais[30];					//pais
	};
	
	//Variaveis de registro do funcionario
	struct registroFunc
	{
		struct nomeFunc nome;        	//struct nome do funcionario
		char funcao[30];				//funcao/cargo
		int ndep;						//numero do dependentes
		float sal;						//salario
		struct endFunc endereco;  		//struct endereco
	};
	struct registroFunc registro;

int main(void) 
{
	//Variaveis
	struct registroFunc cadFunc[3];  // Declaração do array de structs
    int i;
    
    //Leitura de dados
    printf("\nCadastro de Funcionarios\n \n");
    
    for(i=0; i<2; i++)
    {
        printf("Digite o nome do funcionario: ");
        fgets(cadFunc[i].nome.nomef, 30, stdin);
        
        printf("Digite o sobrenome do funcionario: ");
        fgets(cadFunc[i].nome.snome, 30, stdin);
        
        printf("Digite a funcao do funcionario: ");
        fgets(cadFunc[i].funcao, 30, stdin);
        
        printf("Digite salario do funcionario: ");
        scanf("%f", &cadFunc[i].sal);
        getchar();  // Limpar o buffer do teclado
        
        printf("Digite o numero de dependentes do funcionario: ");
        scanf("%d", &cadFunc[i].ndep);
        getchar();  // Limpar o buffer do teclado
        
        printf("Endereco:\n");
        printf("Digite nome da rua: ");
        fgets(cadFunc[i].endereco.rua, 30, stdin);
        
        printf("Digite o numero: ");
        scanf("%d", &cadFunc[i].endereco.num);
        getchar();  // Limpar o buffer do teclado
        
        printf("Digite o CEP: ");
        scanf("%d", &cadFunc[i].endereco.cep);
        getchar();  // Limpar o buffer do teclado
        
        printf("Digite o bairro: ");
        fgets(cadFunc[i].endereco.bairro, 30, stdin);
        
        printf("Digite nome da cidade: ");
        fgets(cadFunc[i].endereco.cid, 30, stdin);
        
        printf("Digite o estado (sigla): ");
        fgets(cadFunc[i].endereco.es, 3, stdin);
        getchar();  // Limpar o buffer do teclado
        
        printf("Digite o pais: ");
        fgets(cadFunc[i].endereco.pais, 30, stdin);
        
        printf("\n-----------------------------------------------\n");
    }
    
    //Imppressão dos dados coletados
    for(i=0; i<2; i++)
    {
        printf("\nDados do Funcionario %d\n", i+1);
        printf("Nome do funcionario: %s", cadFunc[i].nome.nomef);
        printf("Sobrenome: %s", cadFunc[i].nome.snome);
        printf("Funcao: %s", cadFunc[i].funcao);
        printf("Salario: %.2f\n", cadFunc[i].sal);
        printf("Numero de dependentes: %d\n", cadFunc[i].ndep);
        printf("Endereco:\n");
        printf("Rua: %s", cadFunc[i].endereco.rua);
        printf("Numero: %d\n", cadFunc[i].endereco.num);
        printf("CEP: %d\n", cadFunc[i].endereco.cep);
        printf("Bairro: %s", cadFunc[i].endereco.bairro);
        printf("Cidade: %s", cadFunc[i].endereco.cid);
        printf("Estado: %s", cadFunc[i].endereco.es);
        printf("Pais: %s", cadFunc[i].endereco.pais);
    }
	return 0;
}
