#include <iostream>

/*Mostrar o intervalo de 1 a 50
mostrar com enquanto, repita e para*/
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

using namespace std;
int main(int argc, char** argv) {
	
	int n=1;
	
	cout<<"Intervalo entre 1 e 50 \n";
	
	/*enquanto
	
	while(n<51)
	{
		cout<<n<<"\n";
		n=n+1;
	}
	*/
	
	
	/*Repita
	do
	{
		cout<<n<<"\n";
		n=n+1;
		
	}
	while(n<=50);
	*/
	
	/*Para*/
	for(n=1; n<=50; n=n+1)
	{
		cout<<n<<"\n";
	}
	return 0;
}
