package com.example.usuarios.controllers;

import com.example.usuarios.models.UsuarioModel;
import com.example.usuarios.services.UsuarioService;
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
    public ArrayList<UsuarioModel> obtenerUsuarios() {
        return usuarioService.obtenerUsuarios();
    }

    @GetMapping(path = "/{id}")
    public Optional<UsuarioModel> obtenerUsuarioPorId(@PathVariable("id") Long id) {
        return this.usuarioService.obtenerPorId(id);
    }

    @GetMapping("/query")
    public ArrayList<UsuarioModel> obtenerUsuarioPorUsername(@RequestParam("username") String username) {
        return this.usuarioService.obtenerPorUsername(username);
    }

    // Si la peticion POST incluyec id, entonces se actualiza todo el objeto, sino se crea, es decir, dependiendo de id se distingue entre peticion PUT Y POST
    @PostMapping
    public ResponseEntity<?> guardarUsuario(@RequestBody UsuarioModel usuario) {
        if (usuario.getId() == null) {
            return ResponseEntity.status(HttpStatus.CREATED).body(
                    this.usuarioService.guardarUsuario(usuario)
            );
        } else {
            return ResponseEntity.status(HttpStatus.OK).body(
                    this.usuarioService.guardarUsuario(usuario)
            );
        }

    }

    @DeleteMapping(path = "/{id}")
    public String eliminarPorId(@PathVariable("id") Long id) {
        boolean ok = this.usuarioService.eliminarUsuario(id);
        return ok ? "Se elimino el usuario con id " + id : "No se pudo eliminar el usuario con id " + id;
    }

}
