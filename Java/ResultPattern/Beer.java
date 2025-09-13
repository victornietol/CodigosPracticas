package org.example.patronesDiseno.ResultPattern;


public class Beer {
    public String name;

    private Beer(String name) {
        this.name = name;
    }

    public static Result<Beer> create(String name) {
        if(name == null || name.trim().isEmpty())
            return Result.failure("El nombre de la cerveza no puede estar vacio.");
        if(name.length()<3)
            return Result.failure("El nombre debe de ser al menos de 3 caracteres.");
        return Result.success(new Beer(name));
    }
}
