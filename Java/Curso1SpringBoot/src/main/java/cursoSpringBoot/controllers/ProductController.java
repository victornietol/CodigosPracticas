package cursoSpringBoot.controllers;

import cursoSpringBoot.service.ProductService;
import cursoSpringBoot.service.ProductsServiceImpl;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/product")
public class ProductController {
    ProductService productsService = new ProductsServiceImpl(); // Polimorfismo, se utiliza la interface

    @GetMapping
    public ResponseEntity<?> getProducts() {
       return ResponseEntity.ok(productsService.getProducts());
    }
}
