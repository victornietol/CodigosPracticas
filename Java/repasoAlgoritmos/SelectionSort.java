package org.example.repasoAlgoritmos;

import java.util.ArrayList;

public class SelectionSort {

    private SelectionSort() {}

    public static void order(ArrayList<Integer> list) {
        int length = list.size();
        for(int i=0; i<length; i++) {
            int indMin = i;
            for(int j=i+1; j<length; j++) {
                if (list.get(j) < list.get(indMin)) {
                    indMin = j;
                }
            }
            // Intercambiar posición
            int aux = list.get(i);
            list.set(i, list.get(indMin));
            list.set(indMin, aux);
        }
    }
}
