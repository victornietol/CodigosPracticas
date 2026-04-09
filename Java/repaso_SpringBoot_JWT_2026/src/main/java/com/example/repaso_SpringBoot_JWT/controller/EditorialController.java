package com.example.repaso_SpringBoot_JWT.controller;

import com.example.repaso_SpringBoot_JWT.model.Editorial;
import com.example.repaso_SpringBoot_JWT.service.IEditorialService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/editoriales")
public class EditorialController {

    private final IEditorialService service;

    public EditorialController(IEditorialService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<Editorial>> getAll() {
        return ResponseEntity.ok(service.getAll());
    }
}
