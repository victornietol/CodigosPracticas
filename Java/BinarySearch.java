package org.example.repasoAlgoritmos;

import java.util.ArrayList;

public class BinarySearch {

    private BinarySearch() {}

    public static Integer search(ArrayList<Integer> list, int target) {
        // Devuelve el indice
        int start = 0;
        int end = list.size() -1;
        int mid;
        while(start<=end) {
            mid = start + ((end-start)/2);
            if(list.get(mid)==target){
                return mid;
            } else if (target<list.get(mid)) {
                end = mid-1;
            } else {
                start = mid+1;
            }
        }
        return -1; // No se encuentra
    }
}
