package com.example.repasoSencillo_mysql.controller;

import com.example.repasoSencillo_mysql.dto.AutorDTO;
import com.example.repasoSencillo_mysql.model.AutorModel;
import com.example.repasoSencillo_mysql.service.AutorService;
import com.example.repasoSencillo_mysql.service.IAutorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/v1/autores")
public class AutorController {

    private final IAutorService service;

    public AutorController(IAutorService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<AutorModel>> get() {
        return ResponseEntity.ok(service.getAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<AutorModel> getById(@PathVariable Long id) {
        return ResponseEntity.ok(service.getById(id));
    }

    @PostMapping
    public ResponseEntity<AutorModel> create(@RequestBody AutorDTO autorDTO) {
        AutorModel autorCreated =  service.create(autorDTO);
       return ResponseEntity.created(URI.create("api/v1/autores/" + autorCreated.getId()))
               .body(autorCreated);
    }

    @PutMapping("{id}")
    public ResponseEntity<AutorModel> update(@PathVariable Long id, @RequestBody AutorDTO autorDTO) {
        return ResponseEntity.ok(service.update(id, autorDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable Long id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
