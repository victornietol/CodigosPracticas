package cursoSpringBoot.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SaludarRestController {

    @GetMapping("/saludo/{name}") // Asi se recibe un parametro dinamico desde la URL
    public String saludar(@PathVariable String name) { // PathVariable indica que el parametro viene de la URL
        return "Hola " + name;
    }

}
