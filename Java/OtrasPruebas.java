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

    // Implementar otra solucion que sea eficiente
    public static List<Integer> twoSum(List<Integer> numeros, int objetivo) {
        int longitud = numeros.size();
        int suma = 0;
        List<Integer> resultado = new ArrayList<>();
        for(int i=0; i<longitud; i++) { // Verificar elementos
            for(int j = i+1; j<longitud; j++) { // Manejar el segundo indice
                suma = numeros.get(i) + numeros.get(j);
                if(suma==objetivo) {
                    resultado.add(i);
                    resultado.add(j);
                }
            }
        }
        return resultado; // No se encontro solucion
    }

    public static Integer reverseInteger(Number numero) {
        String n = numero.toString();
        StringBuilder sb = new StringBuilder();

        if(n.charAt(0)=='-') {
            sb.append("-");
            for(int i = n.length()-1; i>0; i--) { // Ivertir cadena
                sb.append(n.charAt(i));
            }
        } else {
            for(int i = n.length()-1; i>-1; i--) { // Ivertir cadena
                sb.append(n.charAt(i));
            }
        }
        n = sb.toString();

        try {
            return Integer.parseInt(n);
        } catch (Exception e) {
            return 0;
        }

    }



    public static void main(String[] args) {
        //List res = serieFibonacci(11);
        //int sum = sumaNaturales(5);
        //System.out.println(sum);
        
        //List numeros = new ArrayList<>(Arrays.asList(2,7,11,15));
        //List resultado = twoSum(numeros, 9);
        //System.out.println("resultado = " + resultado);
        
        Number num = 2147483647;
        int res = reverseInteger(num);
        System.out.println("res = " + res);
    }
}
