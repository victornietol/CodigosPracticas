package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.template.example2;

public class Cafe extends Bebida {
    @Override
    void prepararIngrediente() {
        System.out.println("Preparando café");
    }

    @Override
    void agregarExtras() {
        System.out.println("Agregando azúcar");
    }
}
