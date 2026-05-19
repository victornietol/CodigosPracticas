package org.example;

import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class LongestSubstring {
    public static void main(String[] args) {
        String string = "abcabcbb";
        String res = longest(string);
        System.out.println(res);

        string = "bbbbbb";
        res = longest(string);
        System.out.println(res);

        string = "abcabcdbb";
        res = longest(string);
        System.out.println(res);
    }

    public static String longest(String string) {
        Set<Character> chars = new HashSet<>();
        int left = 0;
        int max_length = 0;
        int start = 0;
        int curr_length = 0;

        for (int right=0; right<string.length(); right++) {
            char[] charArray = string.toCharArray();
            while(chars.contains(charArray[right])) { // si hay repetido
                chars.remove(charArray[left++]);
            }
            chars.add(charArray[right]);

            curr_length = right-left+1;

            if(curr_length>max_length) {
                max_length = curr_length;
                start = left;
            }
        }
        return string.substring(start,start+max_length);
    }
}
