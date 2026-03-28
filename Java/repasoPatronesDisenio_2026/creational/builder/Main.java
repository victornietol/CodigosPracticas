package org.example.estructurasDatos.repasoPatronesDisenio_2026.creational.builder;

import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {

    Employee emp = new Employee.Builder()
            .setUsername("user")
            .setEmail("email")
            .setAge(29)
            .setBirthDate(LocalDate.parse("2000-03-23"))
            .setSalary(0.39)
            .setWorkYears(4)
            .build();

    }
}
