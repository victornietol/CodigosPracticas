#include <stdio.h>

int main() {
    // Ingreso del numero a multiplicar
    int numero;
    printf("Ingresa el numero: ");
    scanf("%d", &numero);

    // Bucle para la multiplicacion
    int i;
    int resultado;
    for(i=1; i<=1000000; i++) {
        resultado = numero * i;
        printf("%d*%d=%d\n",numero,i,resultado);
    }
    
    return 0;
}