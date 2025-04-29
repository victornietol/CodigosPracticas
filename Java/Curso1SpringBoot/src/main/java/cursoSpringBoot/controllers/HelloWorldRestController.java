package cursoSpringBoot.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

// Va a responder peticiones GET (clase controladora del tipo REST)
@RestController
public class HelloWorldRestController {

    // Asi se generan los endpoints, se pueden asignar distintas rutas o endpoints para un mismo metodo
    // @GetMapping({"/prueba1","/p1","pr1"})   <- son distintos endpoints que devuelven lo mismo
    @GetMapping("/prueba1") // Ruta para acceder a este metodo
    public String helloWorld() {
        return "Prueba1";
    }
}
