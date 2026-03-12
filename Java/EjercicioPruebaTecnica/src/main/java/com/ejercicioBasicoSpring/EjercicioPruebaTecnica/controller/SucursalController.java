package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.controller;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.SucursalDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service.ISucursalService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/sucursales")
public class SucursalController {

    private final ISucursalService service;

    public SucursalController(ISucursalService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<SucursalDTO>> getAll() {
        return ResponseEntity.ok(service.getSucursales());
    }

    @PostMapping
    public ResponseEntity<SucursalDTO> create(@RequestBody SucursalDTO sucursalDTO) {
        SucursalDTO created = service.createSucursal(sucursalDTO);
        return ResponseEntity.created(URI.create("/api/sucursales/" + created.getId()))
                .body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<SucursalDTO> updateComplete(@PathVariable Long id, @RequestBody SucursalDTO sucursalDTO) {
        return ResponseEntity.ok(service.updateSucursal(id, sucursalDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable Long id) {
        return ResponseEntity.noContent().build();
    }
}
