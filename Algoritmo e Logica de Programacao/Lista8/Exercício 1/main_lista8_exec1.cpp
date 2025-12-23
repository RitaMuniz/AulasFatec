#include <iostream>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */
/*1) Fatorial de um número digitado*/

using namespace std;

int cons(int n)
{
	do
	{
		cout<<"Digite um número positivo: ";
		cin>>n;
	}while(n<0);
	return(n);
}
int fat(int n)
{
	if(n==0)
	{
		return(1);
	}
	else
	{
		return(n*fat(n-1));
	}
	
}
int main(int argc, char** argv) {
	
	int n=0;
	
	cout<<"Fatorial\n";
	n=cons(n);
	cout<<"O fatorial eh: "<<fat(n)<<endl;
	
	return 0;
}
