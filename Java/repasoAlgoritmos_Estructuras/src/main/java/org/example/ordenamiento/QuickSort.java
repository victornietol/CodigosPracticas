package org.example.ordenamiento;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class QuickSort {
    /*
    Complejidad = O(n log n) mejor de los casos; 0(n^2) peor de los casos)
     */

    public static void main(String[] args) {
        List<Integer> list1 = new ArrayList<>();
        for (int i=0; i<21; i++) {
            int num = (int) (Math.random() * 100);
            list1.add(num);
        }

        System.out.println(list1);

        sort(list1, 0, list1.size()-1);

        System.out.println(list1);
    }

    public static void sort(List<Integer> list, int indMin, int indMax) {
        if (indMin < indMax) {
            int pivotIndex = partition(list, indMin, indMax); // Regresa el index del pivote
            sort(list, indMin, pivotIndex-1);
            sort(list, pivotIndex+1, indMax);
        }
    }

    private static int partition(List<Integer> list, int indMin, int indMax) {
        int pivot = medianOfThree(list, indMin, indMax);

        // colocar pivote al final
        int valuePivot = list.get(pivot);
        list.set(pivot, list.get(indMax));
        list.set(indMax, valuePivot);

        int i = indMin-1;
        for (int j=indMin; j<indMax; j++) {
            int curr = list.get(j);
            if (curr < valuePivot) {
                // Intercambiar elementos si el actual es menor al pivote
                Collections.swap(list, ++i, j);
            }
        }

        // reacomodar pivote
        list.set(indMax, list.get(i+1));
        list.set(i+1, valuePivot);

        return i+1;
    }

    private static int medianOfThree(List<Integer> list, int indMin, int indMax) {
        /*
        Selecciona el index del pivote comparando 3 elementos de la lista, regresa el indice
        del elemento central para usarlo como pivote
         */
        int mid = (indMin+indMax)/2;

        int l = list.get(indMin);
        int m = list.get(mid);
        int h = list.get(indMax);

        if(((l<=m) && (m<=h)) || ((h<=m) && (m<=l))) { // central
            return mid;
        }
        if(((m<=l) && (l<=h)) || ((h<=l) && (l<=m))) { // menor
            return indMin;
        }
        return indMax; // mayor
    }
}
