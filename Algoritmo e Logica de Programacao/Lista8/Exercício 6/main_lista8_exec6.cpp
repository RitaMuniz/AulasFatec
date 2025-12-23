#include <iostream>
//NÃO FUNCIONA
/* run this program using the console pauser or add your own getch, system("pause") or input loop */
/*Defina um programa recursivo para, dado um número n, imprimi-lo em base binária.*/

using namespace std;
int cons(int n)
{
	do
	{
		cout<<"Digite: ";
		cin>>n;
	}while(n<0);
	return(n);
}
int bin(int n)
{
	int vet[20], x=0;
	
	for(x=0;x<=19;x=x+1)
	{
		vet[x]=0;
	}
	
	n=bin(n);
	
	if(n==0)
	{
		return(0);
	}
	else if(n==1)
	{
		return(1);
	}
	else
	{
		for(x=0;x<=19;x=x+1)
		{
			n=n/2;
			vet[x]=n%2;
		}
		for(x=0;x<=19;x=x+1)
		{
			cout<<vet[x];
		};
		return(vet[x]);
		
	}
		
	for(x=0;x<=19;x=x+1)
	{
		cout<<vet[x];
	}
}
int main(int argc, char** argv) {
	
	int n=0;
	n=cons(n);
	cout<<bin(n);
	return 0;
}
