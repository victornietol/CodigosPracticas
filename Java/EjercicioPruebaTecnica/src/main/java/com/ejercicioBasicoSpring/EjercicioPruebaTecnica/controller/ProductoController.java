package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.controller;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.ProductoDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Producto;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service.IProductoService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/productos")
public class ProductoController {

    private final IProductoService service;

    public ProductoController(IProductoService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<ProductoDTO>> getAll() {
        return ResponseEntity.ok(service.getProductos());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductoDTO> getById(@PathVariable Long id) {
        return ResponseEntity.ok(service.getById(id));
    }

    @PostMapping
    public ResponseEntity<ProductoDTO> create(@RequestBody ProductoDTO productoDTO) {
        ProductoDTO prodCreated = service.createProducto(productoDTO);
        return ResponseEntity
                .created(URI.create("/api/productos" + prodCreated.getId()))
                .body(prodCreated);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductoDTO> updateComplete(@PathVariable Long id, @RequestBody ProductoDTO productoDTO) {
        return ResponseEntity.ok(service.updateCompleteProducto(id, productoDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable Long id) {
        service.deleteProducto(id);
        return ResponseEntity.noContent().build();
    }
}
