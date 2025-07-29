package org.example.repasoAlgoritmos;

import java.util.ArrayList;
import java.util.Objects;

public class BubbleSort {

    private BubbleSort() {}

    public static void sort(ArrayList<Integer> elements) {
        int move = -1;
        int length = elements.size();
        while(move!=0) {
            move = 0;
            for(int i=0; i<length-1; i++) {
                int curr = elements.get(i);
                int next = elements.get(i+1);
                if(curr > next) {
                    // Intercambiar elementos
                    elements.set(i+1, curr);
                    elements.set(i, next);
                    move++;
                }
            }
        }
        // return elements; // No es necesario regresar un objeto debido a que estoy modificando el objeto al que se hace referencia y no creando uno nuevo
    }
}
