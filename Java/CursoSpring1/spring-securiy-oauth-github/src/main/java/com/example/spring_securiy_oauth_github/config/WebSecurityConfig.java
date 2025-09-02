package com.example.spring_securiy_oauth_github.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;


// ARCHIVO DE CONFIGURACION PARA SECURITY

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    // Aqui se especifican las configuraciones
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws  Exception {
        // Concatenacion de metodos con las configuraciones
        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/", "/login**").permitAll()
                        .anyRequest().authenticated() // Todas las demas rutas requieren authorizacion
                )
                .oauth2Login(Customizer.withDefaults());

        return http.build();
    }
}