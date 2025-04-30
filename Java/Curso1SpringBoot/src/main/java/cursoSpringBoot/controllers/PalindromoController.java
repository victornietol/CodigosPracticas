package cursoSpringBoot.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controllador para verificar palindromos.
 */
@RestController
public class PalindromoController {

    /**
     * Endpoint para verificar si una palabra es unn palindromo
     * @param palabra la cadena a verificar
     * @return Un mensaje si la palabra es un palidromo o no
     */
    @GetMapping("/palindromo/{palabra}")
    public String Palinfromo(@PathVariable String palabra) {
        return esPalindromo(palabra) ? ("La palabra " + palabra + ", SI es palindromo") : ("La palabra " + palabra + ", NO es palindromo");
    }

    // Ejemplo de metodo (Debe ir en otra clase diferente al ser la logica del controlar PalindromoController)
    private boolean esPalindromo(String palabra) {
        int longitud = palabra.length();
        for(int i=0; i<longitud/2; i++) {
            if(palabra.charAt(i) != palabra.charAt(longitud-i-1)) { // Si es diferente entonces no es palindromo
                return false;
            }
        }
        // Si se ejecuta todo el for, entonces es un palindromo
        return true;
    }
}
