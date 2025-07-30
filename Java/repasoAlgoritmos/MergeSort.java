package org.example.repasoAlgoritmos;

import java.util.ArrayList;

public class MergeSort {

    private MergeSort(){}

    public static void sort(ArrayList<Integer> list) {
        ArrayList<Integer> L = new ArrayList<>();
        ArrayList<Integer> R = new ArrayList<>();
        int length = list.size();
        if(length>1) {
            int mid = length/2;
            for(int i=0; i<length; i++) { // Dividir la lista
                if(i<mid) {
                    L.add(list.get(i));
                } else {
                    R.add(list.get(i));
                }
            }
            sort(L);
            sort(R);

            merge(list, L, R); // Unir listas
        }
    }

    private static void merge(ArrayList<Integer> list, ArrayList<Integer> L, ArrayList<Integer> R) {
        int i = 0;
        int j = 0;
        int k = 0;
        // Unir las sublistas
        while(i<L.size() && j<R.size()) {
            if(L.get(i) < R.get(j)) {
                list.set(k, L.get(i));
                i++;
            } else {
                list.set(k, R.get(j));
                j++;
            }
            k++;
        }

        // Acomodar los elementos restantes de las sublistas
        while(i<L.size()) {
            list.set(k++, L.get(i++));
        }

        while(j<R.size()) {
            list.set(k++, R.get(j++));
        }
    }

}
