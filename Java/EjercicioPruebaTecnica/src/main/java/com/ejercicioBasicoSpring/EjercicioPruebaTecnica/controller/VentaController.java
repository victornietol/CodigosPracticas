package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.controller;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.VentaDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service.IVentaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/ventas")
public class VentaController {

    private final IVentaService service;

    public VentaController(IVentaService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<VentaDTO>> getAll() {
        return ResponseEntity.ok(service.getVentas());
    }

    @PostMapping
    public  ResponseEntity<VentaDTO> create(@RequestBody VentaDTO ventaDTO) {
        VentaDTO created = service.createVenta(ventaDTO);
        return ResponseEntity.created(URI.create("/api/ventas/" + created.getId()))
                .body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<VentaDTO> updateComplete(@PathVariable Long id, @RequestBody VentaDTO ventaDTO) {
        return ResponseEntity.ok(service.updateVenta(id, ventaDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable Long id) {
        service.deleteVenta(id);
        return ResponseEntity.noContent().build();
    }
}
