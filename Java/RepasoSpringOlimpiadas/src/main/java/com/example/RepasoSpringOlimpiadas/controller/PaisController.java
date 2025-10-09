package com.example.RepasoSpringOlimpiadas.controller;

import com.example.RepasoSpringOlimpiadas.entity.Pais;
import com.example.RepasoSpringOlimpiadas.service.PaisService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/olimpiadas/paises")
public class PaisController {

    private final PaisService service;

    public PaisController(PaisService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<?> getPaises() {
        return ResponseEntity.ok().body(service.getPaises());
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getById(@PathVariable String id) {
        Pais pais = service.getById(id);
        if (pais!=null) {
            return ResponseEntity.ok().body(pais);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<?> post(@RequestBody Pais pais) {
        Pais paisSaved = service.save(pais);
        if (paisSaved!=null)
            return ResponseEntity.status(HttpStatus.CREATED).body(paisSaved);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Id o Pais ya existente.");
    }

    @PutMapping
    public ResponseEntity<?> put(@RequestBody Pais pais) {
        Pais paisSaved = service.update(pais);
        if (paisSaved!=null)
            return ResponseEntity.status(HttpStatus.OK).body(paisSaved);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Id o Pais no existente.");
    }

    @PatchMapping
    public ResponseEntity<?> patch(@RequestBody Pais pais) {
        Pais paisSaved = service.updatePartial(pais);
        if (paisSaved!=null)
            return ResponseEntity.status(HttpStatus.OK).body(paisSaved);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Id o Pais no existente.");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable String id) {
        if (service.deletePais(id)) {
            String msg = "Pais eliminado con id = " + id;
            return ResponseEntity.status(HttpStatus.OK).body(msg);
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Id o Pais no existente.");
    }
}
