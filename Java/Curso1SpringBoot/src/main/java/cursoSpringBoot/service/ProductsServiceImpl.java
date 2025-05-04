package cursoSpringBoot.service;

import cursoSpringBoot.domain.Product;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ProductsServiceImpl implements ProductService {

    // Los datos de la siguiente lista deben ir en una base de datos, por el momento solo es un ejemplo
    List<Product> products = new ArrayList<>(Arrays.asList(
            new Product(0, "TV", 4500.50, 20),
            new Product(1, "Mouse", 1500.00, 10),
            new Product(2, "Teclado", 2200.50, 20),
            new Product(0, "Telefono", 5300.00, 15)
    ));

    // Comportamiento para el acceso a los datos (se implementa el comportamiento)
    @Override
    public List<Product> getProducts() {
        return products;
    }
}
