#include <iostream>
/*Implementar um programa recursivo em C++ que imprima 
qual o “n” termo da série de Fibonacci. (1,1,2,3,5,8.....)
Por exemplo: Qual o 6º termo da série? O programa deverá informar 8.*/
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

using namespace std;

//Consistir que usuario coloque um numero positivo
int cons(int n)
{
	do
	{
		cout<<"Digite: ";
		cin>>n;
	}while(n<=0);
	return(n);
}

//Recursividade de bibonacci
int fibo(int n)
{
	if(n==1)
	{
		return(1);
	}
	else if(n==2)
	{
		return(1);
	}
	else
	{
		return(fibo(n-1)+fibo(n-2));
	}
}

int main(int argc, char** argv) {
	
	//Variaveis
	int n=0;
	
	//inicio
	cout<<"Fibonacci\n";
	cout<<"Digite o numero do termo da sequencia fibonacci e ele sera mostrado"
	n=cons(n);
	cout<<"O numero do termo eh: "<<fibo(n);
	
	return 0;
}
