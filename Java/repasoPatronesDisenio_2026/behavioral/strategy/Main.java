package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.strategy;

public class Main {
    public static void main(String[] args) {
        ShopCart cart = new ShopCart();

        Product prod1 = new Product("prod1", 90.99);
        Product prod2 = new Product("prod2", 50.99);

        cart.addProduct(prod1);
        cart.addProduct(prod2);

        //crear y usar una opcion de estrategia
        cart.pay(new PaypalStrategy("api", "user", "token"));

        // crear y usar  otra opcion
        cart.pay(new CreditCardStrategy("name", "cardNumber", "cvv", "dateOfExpiry"));

        // si la interfaz tiene un solo metodo entonces es una interfaz funcional,
        // por lo tanto, se pueden utilizar lambdas, ahorrando tener que crear las implementacions
        cart.pay((amount -> System.out.println(amount)));
    }
}
