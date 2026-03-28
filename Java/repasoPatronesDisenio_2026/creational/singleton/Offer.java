package org.example.estructurasDatos.repasoPatronesDisenio_2026.creational.singleton;

import java.util.ArrayList;
import java.util.List;

public class Offer {
    List<Double> prices = new ArrayList<>();

    Calculator calculator = Calculator.getCalculator();

    public double calculateTotalOffer() {
        // Algoritmo de calculadora
        return 0d;
    }
}
