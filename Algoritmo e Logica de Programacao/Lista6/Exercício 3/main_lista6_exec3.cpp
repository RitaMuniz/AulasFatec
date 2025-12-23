#include <iostream>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

/*Criar uma matriz A de 3 linhas e 3 colunas do tipo inteiro
· Solicitar p/ o usuário os valores para inserir na matriz A
· Criar um Vetor B de 3 elementos do tipo inteiro
· Gravar no vetor b a diagonal principal da matriz A
· Após a inserção do valores mostrar a matriz A e o vetor B*/

using namespace std;
int main(int argc, char** argv) {
	
	//Variaveis
	int mata[3][3], vetb[3], x=0, y=0, n=1;
	
	//zerando variaveis
	for(x=0;x<=2;x=x+1)
	{
		for(y=0;y<=2;y=y+1)
		{
			mata[x][y]=0;
		}
	}
	
	for(x=0;x<=2;x=x+1)
	{
		vetb[x]=0;
	}
	
	//inserção dos valores
	
	cout<<"Valores na diagonal\n";
	for(x=0;x<=2;x=x+1)
	{
		for(y=0;y<=2;y=y+1)
		{
			cout<<"Digite o valor "<<n<<": ";
			cin>>mata[x][y];
			n=n+1;
		}
	}
	
	for(x=0;x<=2;x=x+1)
	{
		vetb[x]=mata[x][x];
	}
	
	//valores mostrados
	cout<<"Os valores na matriz fica: \n";
		for(x=0;x<=2;x=x+1)
	{
		for(y=0;y<=2;y=y+1)
		{
			cout<<" | "<<mata[x][y]<<" | ";
		}
		
		cout<<"\n";
	}
	
	cout<<"\nOs valores na diagonal fica: \n";
	for(x=0;x<=2;x=x+1)
	{
		cout<<" | "<<vetb[x]<<" | "<<"\n";
	}
	
	return 0;
}
