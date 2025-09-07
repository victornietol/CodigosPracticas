package com.example.spring_patrones_disenio.creational.singleton;

import java.util.ArrayList;
import java.util.List;

public class Invoice {

    List<Double> prices = new ArrayList<>();

    Calculator calculator = Calculator.getCalculator();

    public double calculateTotalPrice() {
        // Algoritmo que utiliza la calculadora
        // calculator

        return 0d;
    }
}
