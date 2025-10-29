package com.example.Ejemplo_JWT.controller;

import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

// Peticiones para verificar credenciales
@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class UserController {
}
