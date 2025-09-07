package com.example.spring_patrones_disenio.behavioral.strategy;

import java.util.ArrayList;
import java.util.List;

public class ShopCart {

    private List<Product> products;

    public ShopCart() {
        this.products = new ArrayList<>();
    }

    public void addProduct(Product product) {
        this.products.add(product);
    }

    public void removeProduct(Product product) {
        this.products.remove(product);
    }

    // Pagar utilziando una estrategia de pago
    public void pay(PaymentStrategy paymentMethod) {
        // Opcion 1: Iterar de forma funcional
        Double result = products.stream().map(x -> x.getPrice()).reduce(Double::sum).orElse(0d);

        // Opcion 2: iterar de forma imperativa
        double amount = 0;
        for(Product product: products) {
            amount += product.getPrice();
        }

        paymentMethod.pay(amount);
    }
}
