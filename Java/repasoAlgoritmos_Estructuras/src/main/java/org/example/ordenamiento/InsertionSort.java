package org.example.ordenamiento;

import java.util.ArrayList;
import java.util.List;

public class InsertionSort {
    /*
    Time complexity = O(n^2)
    space complexity = O(1)
     */

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
        int currElement;
        int j;

        for (int i=1; i<list.size(); i++) {
            currElement = list.get(i);
            j = i-1;

            while(j>=0  && currElement<list.get(j)) {
                list.set(j+1, list.get(j--));
            }

            list.set(j+1, currElement);
        }
    }
}
