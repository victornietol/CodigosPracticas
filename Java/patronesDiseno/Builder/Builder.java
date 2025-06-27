package org.example.patronesDiseno.Builder;

public class Builder {
    public static void main(String[] args) {
        /* Ayuda para hacer la creacion de objetos de forma mas modular dependiendo de los
         * parametros que necesites. Entonces en lugar de asignar los parametros al
         * instanciar el objeto, esto se hace con metodos. Asi cuando se quieran agregar
         * mas parametros entonces se crean nuevos metodos
         */

        // Sin Builder
        AutomovilPlano autoP = new AutomovilPlano(
                "a1",
                "a2",
                "a3",
                "a4",
                "a5",
                "a6"
        );

        // Con Builder, se pueden asignar los argumentos que se requieran
        AutomovilBuilder autoB = new AutomovilBuilder.BuilderInst()
                .setArg1("a1")
                .setArg2("a2")
                .setArg3("a3")
                .setArg4("a4")
                .setArg5("a5")
                .setArg6("a6")
                .build();
    }
}