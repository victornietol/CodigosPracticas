package com.example.repaso_SpringBoot_JWT.auth.dto;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/prueba")
public class Prueba {
    @GetMapping
    public String get() {
        return "ESTO ES UNA PRUEBA";
    }
}
