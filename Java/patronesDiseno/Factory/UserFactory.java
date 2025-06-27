package org.example.patronesDiseno.Factory;

public class UserFactory {
    public static User create(String type, String data) {
        switch (type) {
            case "admin":
                return new AdminUser(1, data);
            case "moderator":
                return new ModeratorUser(1, data);
            case "regular":
                return new RegularUser(1, data);
            default:
                throw new IllegalArgumentException("Tipo de user desconocido");
        }
    }
}
