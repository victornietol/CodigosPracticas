package cursoSpringBoot.controllers;

import cursoSpringBoot.configurations.ExternalizedConfigurations;
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
    @Qualifier("jsonResourceService") // Se especifica explicitamente cual bean se quiere inyectar, esta notacion tiene prioridad sobre Primary (Si se utiliza la notacion @ConditionalOnProperty(name="service.products", havingValue="json") en la clase de implementacion, entonces esta notacion no se coloca)
    private ProductService productsService; // Hace referencia a la interface, esto es inyeccion de dependencias. Maneja automaticamente la instancia de ProductsServiceImpl (que es un bean con la notacion '@Service')

    // Inyeccion de las variables de configuracion
    @Autowired
    private ExternalizedConfigurations externalizedConfigurations;

    @GetMapping
    public ResponseEntity<?> getProducts() {
        System.out.println(externalizedConfigurations.toString()); // Esta linea no debe ir, solo se hace para mostrar verificar que se inyectan las propiedades de configuracion que se definieron
        
        return ResponseEntity.ok(productsService.getProducts());
    }
}
