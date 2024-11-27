#include <stdio.h>

void torresHanoi(int n_discos, char torreInicio, char torreFinal, char torrePivote);

int main() {
    int n_discos = 7;
    char torreInicio = 'A';
    char torreFinal = 'C';
    char torrePivote = 'B';
    torresHanoi(n_discos, torreInicio, torreFinal, torrePivote);

    return 0;
}

void torresHanoi(int n_discos, char torreInicio, char torreFinal, char torrePivote) {
    if(n_discos == 1) {
        printf("Mover disco 1 de %c a %c\n", torreInicio, torreFinal);
        return;
    }
    torresHanoi(n_discos-1, torreInicio, torrePivote, torreFinal);
    printf("Mover disco %d de %c a %c\n", n_discos, torreInicio, torreFinal);
    torresHanoi(n_discos-1, torrePivote, torreFinal, torreInicio);
}