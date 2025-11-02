package org.example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class EjercicioBinarySearch {
    public static void main(String[] args) {
        List<Integer> list = new ArrayList<>(Arrays.asList(2, 5, 8, 12, 16, 23, 38, 56, 72, 91));
        HashMap<String, Integer> search = binarySearch(list, 72);
        if (search != null) {
            System.out.println("Encontrado: " + search);
        } else {
            System.out.println("No encontrado");
        }
    }

    public static HashMap<String, Integer> binarySearch(List<Integer> list, Integer target) {
        int init = 0;
        int end = list.size() - 1;
        int mid;
        HashMap<String, Integer> result = null;
        while (end >= init) {
            //mid = Math.floorDiv((init + end), 2);
            mid = (init + end) / 2;
            int search = list.get(mid);
            if (search == target) {
                result = new HashMap<>();
                result.put("element", search);
                result.put("index", mid);
                return result;
            } else if (search > target) {
                end = mid-1;
            } else {
                init = mid+1;
            }
        }
        return result;
    }
}
