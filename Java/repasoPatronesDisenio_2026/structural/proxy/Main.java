package org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.proxy;

public class Main {
    public static void main(String[] args) {
        Image img = new ProxyImage("imagen1.jpg");

        // el proxy crea el objeto real por debajo la primera vez
        img.show();

        // el proxy ya tiene el objeto real creado, no lo crea de nuevo
        img.show();
    }
}
