#include<stdio.h>

//Rita de Cassia Muniz de Lima
//Exemplo 9: Senha

int main (void) {
	//Variaveis
	char s[256];
	
	//Usuario
	printf("Bem vindo");
	printf("\nSenha: ");
	gets(s);
	
	//Confirmação
	if(strcmp(s, "alohomora") == 0) { 
		//checa se o que foi escrito é igual a senha declarada
		puts("Senha correta!");
	}
	else {
		puts("Senha incorreta");
	}
	
	return 0;
}
