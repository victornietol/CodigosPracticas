#include <stdio.h>

int factorial(int numero);
int fibonacci(int numero);
void serieFibonacci(int numero);


int main() {
    // Factorial de un numero
    int num = 5;
    int res = factorial(num);
    printf("El factorial de %d es: %d",num,res);
    printf("\n");

    // Serie de fibonacci
    serieFibonacci(num);

    return 0;
}

int factorial(int numero) {
    if(numero== 0 || numero==1) {
        return 1;
    } else {
        return numero * factorial(numero-1);
    }
}

int fibonacci(int numero) {
    if(numero==0) {
        return 0;
    } else if(numero==1) {
        return 1;
    } else {
        return (fibonacci(numero-1) + fibonacci(numero-2));
    }
}

void serieFibonacci(int numero) {
    printf("Serie fibonacci para %d:\n",numero);
    for(int num=0; num<=numero; num++) {
        printf("%d, ",fibonacci(num));
    }
}