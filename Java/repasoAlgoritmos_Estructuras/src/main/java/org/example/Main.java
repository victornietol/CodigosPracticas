package org.example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {

        // Serie de fibonacci
        int fibRec = fibonacciRec(9);
        System.out.println("fibRec = " + fibRec);

        List<Integer> fibList = fibonacciList(9);
        System.out.println("fibList = " + fibList);
        
        
        // Factorial
        int n = 5;
        int fact = factorial(n);
        System.out.println("n= "+ n +", fact = " + fact);
    }
    
    public static int fibonacciRec(int target) {
        if (target == 1) {
            return 0;
        }
        
        if (target==2 || target==3) {
            return 1;
        }
        
        return fibonacciRec(target-1) + fibonacciRec(target-2);
    }

    public static List<Integer> fibonacciList(int nElements) {
        List<Integer> list = new ArrayList<>(Arrays.asList(0,1));

        if (nElements < 3) {
            return list;
        }

        for (int i=2; i<nElements; i++) {
            int newNumber = list.get(i-2) + list.get(i-1);
            list.add(newNumber);
        }

        return list;
    }

    public static int factorial(int n) {
        if (n==1 || n==0) {
            return 1;
        }

        return n * factorial(n-1);
    }
}