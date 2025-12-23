#include <iostream>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

/*Mostrar a soma de todos os números ímpares que são múltiplos de três e que estão entre 0 e o números digitado.*/

using namespace std;

//consistir que seja positivo maior que 0
int cons(int n)
{
	do
	{
		cout<<"Digite: ";
		cin>>n;
	}while(n<0);
}

//formula do impar multiplo de 3
int imp(int n)
{
	if(n==0) //primeira regra: se n=0 (para o código não ficar infinito)
	{
		return(0);
	}
	else //se o numero não for 0
	{
		if(n%2==1) //segunda regra: se o mod de n/2= 1 (ou seja, impar) E
		{
			if(n%3==0) //se ele também tiver mod n/3=0 (ou seja, multiplo de 3)
			{
				return(n+imp(n-2));
			}
			
			else //se não for multiplo de 3
			{
				return(imp(n-1));
			}
		}
		
		else //se não for impar
		{
			return(imp(n-1));
		}
	}
}

int main(int argc, char** argv) {
	
	//Variaveis
	int n=0;
	
	//Inicio
	cout<<"Soma dos Impares multiplos 3\n";
	n=cons(n);
	cout<<imp(n);
	
	return 0;
}
