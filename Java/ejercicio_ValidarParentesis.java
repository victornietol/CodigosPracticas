package org.example;

import java.util.Stack;

public class ejercicio_ValidarParentesis {
    public static void main(String[] args) {
        String s = "{[]}";
        System.out.println(isValid(s));

        s = "]";
        System.out.println(isValid(s));

        s = "mensaje (PRUEBA) va{li[d]o}";
        System.out.println(isValid(s));

        s = "[[{)}]";
        System.out.println(isValid(s));
    }

    public static boolean isValid(String str) {
        /**
         * Validar con texto completo, no solo simbolos
         */
        Stack<Character> stack = new Stack<>();
        for (char c: str.toCharArray()) {
            if (c == '[' || c=='{' || c=='(') stack.push(c);
            else if (c==']' || c=='}' || c==')') {
                if (stack.isEmpty())
                    return false;
                else if (c == ']' && stack.pop() != '[')
                    return false;
                else if (c == '}' && stack.pop() != '{')
                    return false;
                else if (c == ')' && stack.pop() != '(')
                    return false;
            }
        }
        return stack.isEmpty(); // si esta vacio significa que se cerraron todos los simbolos
    }

    public static boolean valid(String s){
        Stack<Character> stack = new Stack<>();

        for (char c : s.toCharArray()) {

            if (c == '(' || c == '{' || c == '[') {
                stack.push(c);
            }

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
