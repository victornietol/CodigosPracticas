package com.example;

public class GestorFacturas {

    Calculator calculator;
    String nombre;

    public GestorFacturas(Calculator calculator, String nombre) {
        System.out.println("Ejecutando constructor GestorFacturas");
        this.calculator = calculator;
        this.nombre = nombre;
    }
}
