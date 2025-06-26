package com.example.ejercicio3.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    private final UserDetailsService userDetailsService;

    public WebSecurityConfig(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(req ->
                            req.requestMatchers("/v1/books/**").permitAll()
                                    .anyRequest().authenticated()
                        )
                .httpBasic(Customizer.withDefaults())
                .userDetailsService(userDetailsService)
                .build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /*
    @Bean
    public UserDetailsService users() {
        UserDetails user = User.builder()
                .username("prueba1")
                .password("{noop}123456") // {noop} indica que no se quiere una contraseña cifrada en este caso
                .roles("USER")
                .build();
        return new InMemoryUserDetailsManager(user);
    }
     */
}
