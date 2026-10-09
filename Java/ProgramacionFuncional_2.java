package org.example;

import java.util.List;
import java.util.stream.Collectors;

class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public double getPrice() {
        return this.price;
    }
}

public class ProgramacionFuncional_2 {
    public static void main(String[] args) {

        List<Product> list = List.of(
                new Product("TV", 3050.40),
                new Product("Smartphone", 200.40),
                new Product("Chair", 45.90),
                new Product("Mouse", 100.40)
        );

        double total = list.stream()
                .filter(p -> p.getPrice() > 100.00)
                .mapToDouble(Product::getPrice)
                .sum();

        System.out.println("res = " + total);

        List<String> names = List.of("Miguel", "ana", "Maria", "pedro", "marta", "Luis");

        List<String> result = names.stream()
                .filter(n -> n.toLowerCase().startsWith("m"))
                .map(String::toUpperCase)
                .sorted()
                .toList();

        System.out.println("names= " + result);
    }

}
