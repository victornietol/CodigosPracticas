package com.example.SpringBoot_MySQL_UUID_prueba.exceptions;

public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException(String message) {
        super(message);
    }
}
