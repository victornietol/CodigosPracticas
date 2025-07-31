package org.example.repasoAlgoritmos;

import java.util.ArrayList;

public class LinearSearch {

    private LinearSearch() {}

    public static Integer search(ArrayList<Integer> list, int target) {
        for(int i=0; i<list.size(); i++) {
            if(list.get(i)==target) {
                return i;
            }
        }
        return -1;
    }
}
