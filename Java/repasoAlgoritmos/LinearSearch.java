package org.example.repasoAlgoritmos;

import java.util.ArrayList;

public class LinearSearch {

    private LinearSearch() {}

    public static Integer search(ArrayList<Integer> list, int target) {
        for(Integer number : list) {
            if(number == target) {
                return number;
            }
        }
        return 0;
    }
}
