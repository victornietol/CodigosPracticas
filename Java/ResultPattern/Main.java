package org.example.patronesDiseno.ResultPattern;

public class Main {
    public static void main(String[] args) {

        Result<Beer> beer = Beer.create("Cerveza1");
        if (beer.isSuccess) {
            System.out.println("Cerveza creada: " + beer.value.name);
        } else {
            System.out.println("Error al crear cerveza: "+ beer.error);
        }


        Result<Beer> beer2 = Beer.create("");
        if (beer2.isSuccess) {
            System.out.println("Cerveza creada: " + beer2.value.name);
        } else {
            System.out.println("Error al crear cerveza: "+ beer2.error);
        }
    }
}
