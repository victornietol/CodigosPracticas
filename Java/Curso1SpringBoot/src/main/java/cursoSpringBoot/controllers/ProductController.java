package cursoSpringBoot.controllers;

import cursoSpringBoot.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/product")
public class ProductController {

    @Autowired
    @Lazy // Indica que la instancia del bean se crea hasta que se utiliza, solo debe utilizarse en los casos requeridos con procesos pesados
    @Qualifier("jsonResourceService") // Se especifica explicitamente cual bean se quiere inyectar, esta notacion tiene prioridad sobre Primary
    private ProductService productsService; // Hace referencia a la interface, esto es inyeccion de dependencias. Maneja automaticamente la instancia de ProductsServiceImpl (que es un bean con la notacion '@Service')

    @GetMapping
    public ResponseEntity<?> getProducts() {
       return ResponseEntity.ok(productsService.getProducts());
    }
}
