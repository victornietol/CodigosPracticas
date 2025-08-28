package com.example.springboot1.config;

// Configuracion de Swagger para documentacion

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


/**
 * Configuracion Swagger para la genaracion de documentacion de la API REST
 *
 * Swagger UI: http://localhost:8081/swagger-ui/index.html
 * OpenAPI JSON: http://localhost:8081/v3/api-docs
 */
@Configuration // Bean de configuracion
public class SwaggerConfig {

    @Bean
    public OpenAPI apiInfo() {
        return new OpenAPI()
                .info(new Info()
                        .title("Spring Boot Book API REST")
                        .description("Library Api rest docs")
                        .version("1.0")
                        .termsOfService("http://www.example.com")
                        .contact(new Contact()
                                .name("Name1")
                                .url("www.contact.com")
                                .email("contact@mail.com"))
                        .license(new io.swagger.v3.oas.models.info.License()
                                .name("MIT")
                                .url("www.licence.com"))
                );
    }
}
