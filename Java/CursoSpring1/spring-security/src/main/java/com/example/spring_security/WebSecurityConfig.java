package com.example.spring_security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
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
                        .requestMatchers("/bootstrap").permitAll() // Asi se indica una ruta permitida sin login, se pueden especificar varias concatenando mas lineas como esta .requestMatchers("/bootstrap").permitAll()
                        .requestMatchers("/public/**").permitAll() // Con esto se puede indicar ciertas rutas como publicas tambien
                        .requestMatchers("/admin/**").hasRole("ADMIN") // Indicar un rol para una ruta (solo users con rol ADMIN pueden acceder)
                        .anyRequest().authenticated() // Todas las demas rutas requieren authorizacion
                )
                .formLogin(Customizer.withDefaults())
                .httpBasic(Customizer.withDefaults());

        return http.build();
    }


    // Manejo de usuarios en memeoria, si se cargaran los datos desde una BD entonces se manejaria diferente ya que esto se realizaria en un bean Service en otra clase
    @Bean
    public InMemoryUserDetailsManager userDetailsService() {
        // Definicion de los usuarios
        UserDetails user = User.withUsername("user")
                .password(passwordEncoder().encode("1234"))
                .roles("USER")
                .build();

        UserDetails admin = User.withUsername("admin")
                .password(passwordEncoder().encode("1234"))
                .roles("USER", "ADMIN")
                .build();

        return new InMemoryUserDetailsManager(user, admin);
    }

    // Para las contraseñas y su cifrado
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
