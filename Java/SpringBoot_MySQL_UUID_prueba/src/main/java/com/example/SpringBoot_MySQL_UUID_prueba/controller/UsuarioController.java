package com.example.SpringBoot_MySQL_UUID_prueba.controller;

import com.example.SpringBoot_MySQL_UUID_prueba.dto.UsuarioDTO;
import com.example.SpringBoot_MySQL_UUID_prueba.model.UsuarioModel;
import com.example.SpringBoot_MySQL_UUID_prueba.service.IUsuarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/usuarios")
public class UsuarioController {
    private final IUsuarioService service;

    public UsuarioController(IUsuarioService service) {
        this.service = service;
    }

    /*
    @GetMapping
    public ResponseEntity<List<UsuarioModel>> get() {
        return ResponseEntity.ok(service.getAll());
    }

    // endpoint con parametro por url: api/v1/usuarios?username=user1234
    @GetMapping
    public ResponseEntity<UsuarioModel> getByUsername(@RequestParam(required = false) String username) {
        return ResponseEntity.ok(service.findByUsername(username));
    }

    -----> LAS DOS FUNCIONES ANTERIORES SE DEBEN JUNTAR PARA EVITAR AMBIGÜEDAD, ENTONCES QUEDA COMO EL SIGUIENTE GET:
    * */

    @GetMapping
    public ResponseEntity<?> get(@RequestParam(required = false) String username) {
        if (username != null) {
            return ResponseEntity.ok(service.findByUsername(username));
        }
        return ResponseEntity.ok(service.getAll());
    }

    @GetMapping("/{uuid}")
    public ResponseEntity<UsuarioModel> getByUuid(@PathVariable UUID uuid) {
        return ResponseEntity.ok(service.findById(uuid));
    }

    @PostMapping
    public ResponseEntity<UsuarioModel> create(@RequestBody UsuarioDTO usuarioDTO) {
        UsuarioModel usuarioCreated = service.create(usuarioDTO);
        return ResponseEntity.created(URI.create("api/v1/usuarios/" + usuarioCreated.getUuid()))
                .body(usuarioCreated);
    }

    @DeleteMapping("/{uuid}")
    public ResponseEntity<Void> deleteByUuid(@PathVariable UUID uuid) {
        service.deleteByUuid(uuid);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteByUsername(@RequestParam String username) {
        System.out.println(username);
        service.deleteByUsername(username);
        return ResponseEntity.noContent().build();
    }
}
