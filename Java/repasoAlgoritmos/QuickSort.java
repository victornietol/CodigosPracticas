package org.example.repasoAlgoritmos;

import java.util.ArrayList;

public class QuickSort {

    private QuickSort(){}

    public static void sort(ArrayList<Integer> list, int indLow, int indHigh) {
        if(indLow<indHigh) {
            int pi = partition(list, indLow, indHigh);
            sort(list, indLow, pi-1); // Ajustar parte izquierda
            sort(list, pi+1, indHigh); // Ajustar parte derecha
        }
    }

    private static int partition(ArrayList<Integer> list, int indLow, int indHigh) {
        int pivotIndex = medianOfThree(list, indLow, indHigh);
        // Colocar pivote al final
        int aux = list.get(indHigh);
        list.set(indHigh, list.get(pivotIndex));
        list.set(pivotIndex, aux);
        int pivot = list.get(indHigh);
        int i = indLow-1;
        for(int j=indLow; j<indHigh; j++) {
            if(list.get(j) < pivot) {
                i++;
                // Intercambiar elementos
                aux = list.get(j);
                list.set(j, list.get(i));
                list.set(i, aux);
            }
        }
        // Reacomodar pivote
        aux = list.get(indHigh);
        list.set(indHigh, list.get(i+1));
        list.set(i+1, aux);
        return i+1;
    }

    private static int medianOfThree(ArrayList<Integer> list, int indLow, int indHigh) {
        int mid = (indLow+indHigh)/2;
        // Obtener elementos
        int l = list.get(indLow);
        int m = list.get(mid);
        int h = list.get(indHigh);
        if( (l<=m && m<=h) || (h<=m && m<=l) ) {
            return mid;
        }
        if( (m<=l && l<=h) || (h<=l && l<=m) ) {
            return indLow;
        }
        return indHigh;
    }

}
