package com.example.spring_patrones_disenio.creational.builder;

public class MainUser {

    public static void main(String[] args) {

        // Permite que el usuario cree los objetos dinamicamente segun los atributos que necesite
        User user1 = new User.Builder().setId(1L).setFirstName("firstName").setLastName("lastName").build();
        User user2 = new User.Builder().setId(2L).setFirstName("firstName2").setLastName("lastName2").setEmail("USER@mail.com").build();
    }
}
