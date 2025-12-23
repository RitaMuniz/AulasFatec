#include <iostream>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

/*Criar uma matriz A 3x3 do tipo inteiro
· Solicitar p/ o usuário os valores e inserí-los na matrizA
· Criar uma matrizB 3x3 do tipo inteiro
· Gravar na matrizB a transposta da matriz A
· Após a inserção dos valores mostrar as duas matrizes*/


using namespace std;
int main(int argc, char** argv) {
	
	//Variaveis
	int mata[3][3], matb[3][3], x=0, y=0, n=1;
	
	
	//zerando matrizes
	for(x=0; x<=2; x=x+1)
	{
		for(y=0; y<=2; y=y+1)
		{
			mata[x][y]=0;
			matb[x][y]=0;
		}
	}
	
	cout<<"Transporta Matriz 3x3\n";
	
	//inserção dos valores na matrizA
	for(x=0; x<=2; x=x+1)
	{	
		for(y=0; y<=2; y=y+1)
		{
			cout<<"Digite valor "<<n<<": ";
			cin>>mata[x][y];
			n=n+1;
		}
	}
	
	//Inserindo valores na matriz B
	for(x=0; x<=2; x=x+1)
	{
		for(y=0; y<=2; y=y+1)
		{
			matb[x][y]=mata[y][x];
		}
	}
		
		
	//Mostrando Matriz A	
	cout<<"A matriz inserida (Matriz A): \n";
	
	for(x=0; x<=2; x=x+1)
	{
		for(y=0; y<=2; y=y+1)
		{
			cout<<" | "<<mata[x][y]<<" | ";
		}
		
		cout<<"\n";
	}
	
	//Mostrando Matriz B
	cout<<"A matriiz transpota (Matriz B) fica: \n";
	
	for(x=0; x<=2; x=x+1)
	{
		for(y=0; y<=2; y=y+1)
		{
			cout<<" | "<<matb[x][y]<<" | ";
		}
		
		cout<<"\n";
	}
	
	return 0;
}
