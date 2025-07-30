package org.example.repasoAlgoritmos;

import java.util.ArrayList;

public class InsertionSort {

    private InsertionSort() {}

    public static void sort(ArrayList<Integer> list) {
        int length = list.size();
        for(int i=1; i<length; i++) {
            int currValue = list.get(i);
            int j = i-1;
            while((j>=0) && list.get(j)>currValue) {
                list.set(j+1, list.get(j)); // Recorriendo valor
                j--;
            }
            list.set(++j, currValue); // Acomodando el valor con el que se comparó
        }
    }

}
