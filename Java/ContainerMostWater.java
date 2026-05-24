package org.example.estructurasDatos.ejercicios;

import java.util.ArrayList;
import java.util.List;

public class ContainerMostWater {
    public static void main(String[] args) {
        int[] nums = {1,8,6,2,5,4,8,3,7};
        int res = maxArea(nums);
        System.out.println(res);
    }

    public static int maxArea(int[] height) {
        int left = 0; // inicio
        int right = height.length-1; // puntero del final
        int maxArea = 0;

        while (left<right) {
            int width = right - left;
            int currHeight = Math.min(height[left], height[right]);
            int area = width * currHeight;
            maxArea = Math.max(maxArea, area);

            // mover puntero menor
            if (height[left] < height[right]) {
                left++;
            } else {
                right--;
            }
        }

        return maxArea;
    }

}
