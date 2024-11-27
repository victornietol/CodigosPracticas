#include <stdio.h>
#include <stdbool.h>


#define TAM_TAB 8 // Tamanio del tablero

// Funciones a utilizar
bool espacioLibre(char tab[][TAM_TAB], int ren, int col);
bool colocarReinas(char tab[][TAM_TAB], int ren);

int main() {
    // Creando tablero
    // Los espacios vacios son "."
    char tablero[8][8];
    int inicio = 0; // Primer renglon
    for(int ren=0; ren<8; ren++) {
        for(int col=0; col<8; col++) {
            tablero[ren][col] = '.';
        }
    }

    // Tratando de colocar reinas en el tablero
    if(colocarReinas(tablero, inicio)) {
        for(int i=0;i<8;i++) {  // Imprimiendo tablero si se llego a una solucion
            for(int j=0;j<8;j++){
                printf("%c ",tablero[i][j]);
            }
            printf("\n");
        }
    } else {    // Muestra error
        printf("Error en la solucion");
    }

    return 0;
}

// Funcion para verificar si hay espacio libre
bool espacioLibre(char tab[][TAM_TAB], int ren, int col) {
    int r,c; // Variables para manejar los renglones y columnas

    for(r=0; r<ren; r++) {  // Verificando si hay espacio libre en esa columna (ninguna reina hacia arriba en la columna)
        if(tab[r][col] == '*') {
            return false;
        }
    }

    for(r=ren,c=col; r>=0 && c>=0; r--,c--) { // Verificando si hay reina en diagonal superior izquierda
        if(tab[r][c] == '*') {
            return false;
        }
    }

    for(r=ren,c=col; r>=0 && c<TAM_TAB; r--,c++) { // Verificando si hay reina en diagonal sup derecha
        if(tab[r][c] == '*') {
            return false;
        }
    }

    return true; // Si no encuentra ninguna reina, entonces es un espacio libre
}

// Funcion para colocar reinas
bool colocarReinas(char tab[][TAM_TAB], int ren) {
    if(ren >= TAM_TAB) { // En caso de llegar al limite del tamanio del tablero
        // Verificar que esten todas las reinas colocadas
        int reinas = 0; // Conteo de reinas
        for(int r=0; r<TAM_TAB; r++) {
            for(int c=0; c<TAM_TAB; c++) {
                if(tab[r][c] == '*') {
                    reinas++;
                }
            }
        }
        if(reinas == 8) {
            return true; // Se colocaron todas las reinas
        } else {
            return false; // No se llego a una solucion
        }
    }

    for(int col=0; col<TAM_TAB; col++) { // Intento de colocar una reina en una columna de la fila actual
        if(espacioLibre(tab, ren, col)) {
            tab[ren][col] = '*';
            if(colocarReinas(tab, ren+1)) { // Intento de colocar otra reina en el sig renglon
                return true;
            } else {
                tab[ren][col] = '.'; // Si no es posible colocar otra reina se pone nuevamente el lugar como vacio
            }
        }
    }

    return false; // No se pudo colocar la reina en ninguna columna y fallo la solucion
}