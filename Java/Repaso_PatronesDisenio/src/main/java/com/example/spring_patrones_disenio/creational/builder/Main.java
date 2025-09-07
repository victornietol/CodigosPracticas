package com.example.spring_patrones_disenio.creational.builder;

public class Main {
    public static void main(String[] args) {
        User user = new User.Builder().setId(1L).build();

        User user2 = new User.Builder().setId(1L).setEmail("user2@email").build();

        User user3 = new User.Builder().setId(1L).setEmail("user3@email").setFirstName("add").build();

        User user4 = new User.Builder().setId(1L).setEmail("user4@email").setFirstName("another").setLastName("last").build();

    }
}
