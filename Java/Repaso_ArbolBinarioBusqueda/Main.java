package org.example;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;


public class Main {
    public static void main(String[] args) {

        int[] valoresNodos = {8, 3, 10, 1, 6, 14, 4, 7, 13};
        ArbolBinarioBusqueda arbol = new ArbolBinarioBusqueda();

        for(int valor: valoresNodos) {
            Nodo n;
            n = arbol.insertar(new Nodo(valor));
            System.out.println(n);
        }

        System.out.println(arbol);

        Nodo n;
        n = arbol.buscarNodoPorValor(10);
        System.out.println(n);

        arbol.insertar(new Nodo(9));
        System.out.println(n);

    }
}