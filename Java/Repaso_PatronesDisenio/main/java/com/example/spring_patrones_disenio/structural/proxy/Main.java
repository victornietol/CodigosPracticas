package com.example.spring_patrones_disenio.structural.proxy;

public class Main {
    public static void main(String[] args) {

        Image img = new ProxyImage("imagen1.jpg");

        // El proxy crea el objeto real por debajo la primera vez
        img.show();

        // El proxy ya tiene el objeto real creado no lo crea de nuevo
        img.show();
    }
}
