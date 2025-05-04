package cursoSpringBoot.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import cursoSpringBoot.domain.Product;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Lazy // Indica que la instancia del bean se carga hasta que se utiliza
// @Primary // Bean prioritario (predeterminado), en caso de utilizar Qualifier entonces se elige el especificado sobre el indicando con Primary
// @ConditionalOnProperty(name="service.products", havingValue="json") // Para asignar o indicar el bean desde el archivo de configuracion (application.properties o application.yml), 'name' debe ser el mismo valor del nombre de la propiedad asignada en el archivo de configuracion. havingValue es el nombre que se le asigna al bean y debe ser el mismo que el valor de la propiedad en el archivo de config. Cuando se utiliza esta anotacion entonces solo se carga al inicio del programa este bean y no los demas del mismo tipo, mientras que si no se usa esta notacion entonces si se cargan al inicio todos los beans del mismo tipo aunque no se utilicen. Ejemplo de variable en archivo de config: service.products=json
@Service("jsonResourceService") // Bean de servicio
public class ProductsServiceJSONImpl implements ProductService {

    public ProductsServiceJSONImpl() {
        System.out.println("Instancia de la clase ProductsServiceJSONImpl");
    }

    @Override
    public List<Product> getProducts() {
        List<Product> products;
        try {
            // Deserializando para almacenar los datos
            products = new ObjectMapper().readValue(
                    this.getClass().getResourceAsStream("/products.json"),
                    new TypeReference<List<Product>>() {}
            );
            return products;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
