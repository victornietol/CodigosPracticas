package com.example.repasoSencillo_Spring.Controller;

import com.example.repasoSencillo_Spring.Entity.LibroEntity;
import com.example.repasoSencillo_Spring.Service.LibroService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/api/libros")
public class LibroController {

    private final LibroService service;

    public LibroController(LibroService service){
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<LibroEntity>> get() {
        return ResponseEntity.ok(service.getAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<LibroEntity> getById(@PathVariable Long id){
        return service.getById(id)
                .map(libro -> ResponseEntity.ok(libro))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<LibroEntity> create(@RequestBody LibroEntity libro) {
        return ResponseEntity.status(HttpStatus.CREATED).body(
                service.save(libro)
        );
    }

    @PutMapping
    public ResponseEntity<LibroEntity> update(@RequestBody LibroEntity libro) {
        if (!service.existById(libro.getId())) {
            return ResponseEntity.notFound().build();
        }

        LibroEntity libroUpdated = service.save(libro);
        return ResponseEntity.ok(libroUpdated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if(!service.existById(id)) {
            return ResponseEntity.notFound().build();
        }

        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
