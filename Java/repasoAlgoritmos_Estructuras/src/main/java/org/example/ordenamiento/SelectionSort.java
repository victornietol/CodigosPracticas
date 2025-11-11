package org.example.ordenamiento;

import java.util.ArrayList;
import java.util.List;

public class SelectionSort {

    public static void main(String[] args) {
        List<Integer> list1 = new ArrayList<>();
        for (int i=0; i<20; i++) {
            int num = (int) (Math.random() * 100);
            list1.add(num);
        }

        System.out.println(list1);

        sort(list1);

        System.out.println(list1);
    }

    public static void sort(List<Integer> list) {
        int indexMin;
        int aux;

        for(int i=0; i<list.size()-1; i++) {
            indexMin = i;

            for(int j=i+1; j<list.size(); j++) {
                indexMin = (list.get(j)<list.get(indexMin)) ? j : indexMin;
            }

            if (indexMin != i) {
                aux = list.get(indexMin);
                list.set(indexMin, list.get(i));
                list.set(i, aux);
            }
        }
    }
}
