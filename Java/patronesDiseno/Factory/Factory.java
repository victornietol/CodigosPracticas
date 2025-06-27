package org.example.patronesDiseno.Factory;

public class Factory {
    public static void main(String[] args) {
        /* Maneja la creacion de objetos para poder crear distintos tipos de objeto segun
        * se requiera. Por ejemplo, crear distintos tipos de Users bajo alguna condicion.
        * El objetivo es ingresar los parametros necesarios para el objeto y dependiendo
        * de estos parametros entonces crear el objeto correspondiente. (Ocultar la logica
        * de la creacion de objetos)
        * */

        String type = "admin";
        String data = "datos...";
        User user;

        // Sin Factory
        if(type=="admin") {
            user = new AdminUser(1, data);
        } else if (type=="moderator") {
            user = new ModeratorUser(1, data);
        } else {
            user = new RegularUser(1, data);
        }

        // Con Factory (automaticamente se asigna el tipo de usuario)
        User newUser = UserFactory.create("admin", data);
    }
}