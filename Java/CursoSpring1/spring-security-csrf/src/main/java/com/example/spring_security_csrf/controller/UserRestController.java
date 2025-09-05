package com.example.spring_security_csrf.controller;

import com.example.spring_security_csrf.dto.UserDTO;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class UserRestController {

    // urls permitidas
    @GetMapping("/prueba1")
    public String prueba1() {
        return "Prueba 1";
    }

    // urls autenticadas
    @PostMapping("/users")
    public String save(@RequestBody UserDTO user) {
        System.out.println(user);
        return "ok";
    }

    @GetMapping("/prueba2")
    public String prueba2() {
        return "Prueba2";
    }
}
