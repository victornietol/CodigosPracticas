package com.example.spring_patrones_disenio.creational.builder.example;

import java.util.Calendar;

public class Main {
    public static void main(String[] args) {

        StringBuilder articulo = new StringBuilder().append("cadena1").append("cad2").append(30);

        System.out.println(articulo);

        Calendar calendar = new Calendar.Builder().setCalendarType("gregory").setDate(2025, 9,20).build();
    }
}
