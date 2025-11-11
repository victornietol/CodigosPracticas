package org.example.ordenamiento;

import java.util.ArrayList;
import java.util.List;

public class BubbleSort {

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

    public static List<Integer> sort(List<Integer> list) {
        boolean change = true;
        while (change) {
            change = false;
            for (int i=0; i<list.size()-1; i++) {
                if (list.get(i) > list.get(i+1)) {
                    int aux = list.get(i+1);
                    list.set(i+1, list.get(i));
                    list.set(i, aux);
                    change = true;
                }
            }
        }
        return list;
    }
}
