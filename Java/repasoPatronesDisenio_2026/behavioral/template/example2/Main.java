package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.template.example2;

public class Main {
    public static void main(String[] args) {
        System.out.println("Bebida 1 -------");
        Bebida cafe = new Cafe();
        cafe.preparar();

        System.out.println("\nBebida 2 -------");
        Bebida te = new Te();
        te.preparar();
    }
}
