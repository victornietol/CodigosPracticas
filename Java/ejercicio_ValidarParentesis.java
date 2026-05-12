package org.example;

import java.util.Stack;

public class ejercicio_ValidarParentesis {
    public static void main(String[] args) {
        String s = "{[]}";

        System.out.println(valid(s));
    }

    public static boolean valid(String s){
        Stack<Character> stack = new Stack<>();

        for (char c : s.toCharArray()) {

            // Abrir
            if (c == '(' || c == '{' || c == '[') {
                stack.push(c);
            }

            // Cerrar
            else {
                if (stack.isEmpty()) {
                    return false;
                }
                char top = stack.pop();
                if (c == ')' && top != '(') {
                    return false;
                }
                if (c == '}' && top != '{') {
                    return false;
                }
                if (c == ']' && top != '[') {
                    return false;
                }
            }
        }

        return stack.isEmpty();
    }
}
