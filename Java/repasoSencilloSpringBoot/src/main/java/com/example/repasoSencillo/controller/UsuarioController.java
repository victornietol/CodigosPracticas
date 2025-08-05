package com.example.repasoSencillo.controller;

import com.example.repasoSencillo.models.UsuarioModel;
import com.example.repasoSencillo.services.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Optional;

@RestController
@RequestMapping("/usuario")
public class UsuarioController {

    @Autowired
    UsuarioService usuarioService;

    @GetMapping
    public ResponseEntity<ArrayList<UsuarioModel>> getUsuarios() {
        return ResponseEntity.status(HttpStatus.OK).body(
          this.usuarioService.getUsuarios()
        );
    }

    @GetMapping(path = "/{id}")
    public ResponseEntity<UsuarioModel> getUsuarioById(@PathVariable("id") Long id) {
        Optional<UsuarioModel> user = usuarioService.getById(id);

        return user.isPresent() ? ResponseEntity.ok(user.get()) : ResponseEntity.notFound().build();
    }

    @GetMapping("/query")
    public ResponseEntity<ArrayList<UsuarioModel>> getUsuarioByUsername(@RequestParam("username") String username) {
        return ResponseEntity.status(HttpStatus.OK).body(
                this.usuarioService.getByUsername(username)
        );
    }

    @PostMapping
    public ResponseEntity<?> saveUsuario(@RequestBody UsuarioModel user) {
        if (user.getId() == null) { // Sin ID se crea nuevo
            return ResponseEntity.status(HttpStatus.CREATED).body(
                    this.usuarioService.saveUsuario(user)
            );
        } else { // Si trae ID se actualiza
            return ResponseEntity.status(HttpStatus.OK).body(
                    this.usuarioService.saveUsuario(user)
            );
        }
    }

    @DeleteMapping(path = "/{id}")
    public ResponseEntity<?> deleteById(@PathVariable("id") Long id) {
        boolean ok = this.usuarioService.deleteUsuario(id);
        return ok ? ResponseEntity.ok("Se elimino el elmento con id "+id)
                : ResponseEntity.status(HttpStatus.NOT_FOUND).body("No se encontro el elemento con id "+id);
    }
}
