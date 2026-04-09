package com.example.repaso_SpringBoot_JWT.controller;

import com.example.repaso_SpringBoot_JWT.model.Autor;
import com.example.repaso_SpringBoot_JWT.service.IAutorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/autores")
public class AutorController {

    private final IAutorService service;

    public AutorController(IAutorService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<Autor>> get() {
        return ResponseEntity.ok(service.getAll());
    }
}
