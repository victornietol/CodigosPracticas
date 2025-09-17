package org.example.solid.s.bad_impl;

public class User {
    private String name;

    public User(String name) {
        this.name = name;
    }

    public void saveUserToDatabase() {
        // Database logic to save user
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
