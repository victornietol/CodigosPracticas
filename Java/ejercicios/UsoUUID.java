package org.example.estructurasDatos.ejercicios;

import java.util.UUID;

public class UsoUUID {
    public static void main(String[] args) {
        UUID uuidRandom1 = UUID.randomUUID();
        UUID uuidRandom2 = UUID.randomUUID();

        System.out.println("UUID rand 1: " + uuidRandom1);
        System.out.println("UUID rand 2: " + uuidRandom2);

        String uuidString = uuidRandom1.toString();
        System.out.println(uuidString + " -> " + uuidString.getClass().getSimpleName());
        UUID uuidFromString = UUID.fromString(uuidString);
        System.out.println(uuidFromString + " -> " + uuidFromString.getClass().getSimpleName());
    }
}
