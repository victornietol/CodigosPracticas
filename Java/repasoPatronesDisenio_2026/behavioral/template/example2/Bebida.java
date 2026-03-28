package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.template.example2;

public abstract class Bebida {

    // template (define el algoritmo)
    public final void preparar() {
        hervirAgua();
        prepararIngrediente();
        servir();
        agregarExtras();
    }

    private void hervirAgua() {
        System.out.println("Hirviendo agua");
    }

    abstract void prepararIngrediente();

    private void servir() {
        System.out.println("Sirviendo en taza");
    }

    // hook (opcional)
    void agregarExtras() {
        // opcional
    }
}
