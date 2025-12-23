#include <iostream>

/*Mostrar os impares entre 10 e 80 o a somatória deles.
mostrar em enquanto, para e repita*/
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

using namespace std;
int main(int argc, char** argv) {
	
	int n=11, s=0;
	
	cout<<"impares de 10 a 80\n";
	
	/*enquanto
	while(n<=80)
	{
		s=s+n;
		cout<<n<<"\n";
		n=n+2;
	}
	*/
	
	/*Repita
	do
	{
		s=s+n;
		cout<<n<<"\n";
		n=n+2;
	}
	while(n<=80);
	*/
	
	/*Para*/
	for(n=11; n<=80; n=n+2)
	{
		s=s+n;
		cout<<n<<"\n";
	}
	
	
	cout<<"\nA noma de todos os numeros impares eh: "<<s;
	
	return 0;
}
