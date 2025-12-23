#include <stdlib.h>
#include <stdio.h>

int main (void) {
    
    int dia = 0;
    int mes = 0;
    
    printf("Descubra seu signo\n");
    
    do{
        printf("Digite o dia que voce nasceu: ");
        scanf("%d", &dia);
    } while((dia < 1) || (dia > 31));
    
    do{
        printf("Digite o numero do mes que voce nasceu: ");
        scanf("%d", &mes);
    } while((mes < 1) || (mes > 12));
    
    switch (mes) {
           
           case 1 : if(dia>=21) { printf("Aquario");} else {printf("Capricornio");} break;
           case 2 : if(dia>=19) { printf("Peixes");} else { printf("Aquario");} break;
           case 3 : if(dia>=21) { printf("Aries");} else { printf("Peixes");} break;
           case 4 : if(dia>=21) { printf("Touro");} else { printf("Aries");} break;
           case 5 : if(dia>=21) { printf("Gemeos");} else { printf("Touro");} break;
           case 6 : if(dia>=21) { printf("Cancer");} else { printf("Gemeos");} break;
           case 7 : if(dia>=23) { printf("Leao");} else { printf("Cancer");} break;
           case 8 : if(dia>=23) { printf("Virgem");} else { printf("Leao");} break;
           case 9 : if(dia>=23) { printf("Libra");} else { printf("Virgem");} break;
           case 10 : if(dia>=22) { printf("Escorpiao");} else { printf("Libra");} break;
           case 11 : if(dia>=22) { printf("Sargitario");} else { printf("Escorpiao");} break;
           case 12 : if(dia>=22) { printf("Capricornio");} else { printf("Sargitario");} break;
           
           default: printf("erro");
           
    }
    
    scanf("%d");
    return 0;
}
