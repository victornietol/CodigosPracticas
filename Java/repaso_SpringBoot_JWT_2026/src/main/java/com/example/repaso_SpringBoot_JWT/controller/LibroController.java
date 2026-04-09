package com.example.repaso_SpringBoot_JWT.controller;

import com.example.repaso_SpringBoot_JWT.model.Libro;
import com.example.repaso_SpringBoot_JWT.service.ILibroService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/libros")
public class LibroController {

    private final ILibroService service;

    public LibroController(ILibroService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<Libro>> getAll() {
        return ResponseEntity.ok(service.getAll());
    }
}
