package org.example;

public class cifradoCesar {

    public static void main(String[] args) {
        String text = "Hola que tal";
        int key = 592050;
        System.out.println("Texto plano: " + text);

        String encText = encrypt(text, key);
        System.out.println("Texto cifrado: " + encText);

        String decText = decrypt(encText, key);
        System.out.println("Texto descifrado: "+ decText);
    }

    public static String encrypt(String text, Integer key) {
        int charMaxValue = Character.MAX_VALUE +1; // total de caracteres posibles utf-16
        StringBuilder textEncrypted = new StringBuilder();

        for(char c: text.toCharArray()) {
            int charValue = (int) c;
            charValue = (charValue + key) % charMaxValue;
            textEncrypted.append((char) charValue);
        }

        return textEncrypted.toString();
    }

    public static String decrypt(String text, Integer key) {
        int charMaxValue = Character.MAX_VALUE +1;
        StringBuilder textDecrypted = new StringBuilder();

        for(char c: text.toCharArray()) {
            int charValue = (int) c;
            charValue = Math.floorMod(charValue-key, charMaxValue);
            textDecrypted.append((char) charValue);
        }

        return textDecrypted.toString();
    }
}
