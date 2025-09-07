package com.example.spring_patrones_disenio.behavioral.strategy;

public class Main {
    public static void main(String[] args) {

        ShopCart cart = new ShopCart();

        Product product1 = new Product("prod1", 90.99);
        Product product2 = new Product("prod2", 60.99);

        cart.addProduct(product1);
        cart.addProduct(product2);

        // Crear y usar una opcion de estategia
        cart.pay(new PaypalStrategy("api","user","token"));

        // Crear y usar otra opcion de estrategia
        cart.pay(new CreditCardStrategy("name", "cardNumber", "cvv", "dateOfExpiry"));

        // Si la interfaz tiene un solo metodo entonces es una interfaz funcional  y por
        // tanto, se pueden utilizar lambdas, ahorrando asi tener que crear las implementaciones estrategia
        cart.pay(
                (amount) -> System.out.println(amount)
        );

    }
}
