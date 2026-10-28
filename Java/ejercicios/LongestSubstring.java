package org.example.estructurasDatos.ejercicios;

import java.util.HashSet;
import java.util.Set;

public class LongestSubstring {
    public static void main(String[] args) {
        int length;
        String str = "abcabcbb";
        length = longestSubstring(str);
        System.out.println(length);

        str = "bbbbbb";
        length = longestSubstring(str);
        System.out.println(length);

        str = "abcabcdbb";
        length = longestSubstring(str);
        System.out.println(length);
    }

    public static int longestSubstring(String str) {
        int maxLength = 0;
        int left = 0;
        Set<Character>  chars = new HashSet<>();

        for(int right=0; right < str.length(); right++) {
            while ( chars.contains(str.charAt(right)) ) {
                chars.remove(str.charAt(left++));
            }
            chars.add(str.charAt(right));
            maxLength = Math.max(maxLength, (right - left + 1));
        }
        return  maxLength;
    }
}
