package org.example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class OtrasPruebas {

    public static Integer factorial(int numero) {
        int resultado = 1;
        if(numero==0){
            return 1;
        } else {
            for(int i=1; i<=numero; i++) {
                resultado *= i;

            }
            return resultado;
        }
    }

    public static Integer factorialRec(int numero) {
        if(numero < 0) {
            return null;
        } else if(numero==1 || numero==0) {
            return 1;
        } else {
            return numero * factorialRec(numero-1);
        }
    }

    public static Integer elementoFibonacciRec(int indElemento) {
        /**
         * Indice inicia en 0
         */
        if(indElemento==0) {
            return 0;
        } else if(indElemento==1) {
            return 1;
        } else {
            return elementoFibonacciRec(indElemento-1) + elementoFibonacciRec(indElemento-2);
        }
    }

    public static List<Integer> serieFibonacci(int numElementos) {
        List<Integer> serie = new ArrayList<>(Arrays.asList(0,1));
        for(int i=2; i<numElementos; i++) {
            int elemento = serie.get(i-1) +serie.get(i-2);
            serie.add(elemento);
        }
        return serie;
    }

    public static int sumaNaturales(int cantidad) {
        /**
         * Suma de los N primeros numeros naturales.
         * cantidad = cantidad de numeros a sumar.
         */
        int sumatoria = 0;
        if(cantidad==0) {
            return 0;
        } else {
            for(int i=1; i<=cantidad; i++) {
                sumatoria += i;
            }
            return  sumatoria;
        }
    }



    public static void main(String[] args) {
        List res = serieFibonacci(11);
        int sum = sumaNaturales(5);
        System.out.println(sum);
    }
}
