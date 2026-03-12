package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.ProductoDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.exception.NotFoundException;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.mapper.Mapper;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Producto;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.repository.ProductoRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class ProductoService implements IProductoService {

    private final ProductoRepository repository;

    public ProductoService(ProductoRepository productoRepository) {
        this.repository = productoRepository;
    }

    @Override
    public List<ProductoDTO> getProductos() {
        return repository.findAll().stream().map(Mapper::toDTO).toList();
    }

    @Override
    public ProductoDTO getById(Long id) {
         Producto p = repository.findById(id)
                 .orElseThrow(() -> new NotFoundException("Producto no encontrado"));
         return Mapper.toDTO(p);
    }

    @Override
    public ProductoDTO createProducto(ProductoDTO productoDTO) {
        System.out.println("UNIIIITS DTO: " + productoDTO.getUnits());
        Producto prod = Producto.builder()
                .name(productoDTO.getName())
                .category(productoDTO.getCategory())
                .price(productoDTO.getPrice())
                .units(productoDTO.getUnits())
                .build();
        System.out.println("UNIIIITS PROD: " + prod.getUnits());
        return Mapper.toDTO(repository.save(prod));
    }

    @Override
    public ProductoDTO updateCompleteProducto(Long id, ProductoDTO productoDTO) {
        // verificar que exista el producto
        Producto prod = repository.findById(id)
                .orElseThrow(() -> new NotFoundException("Producto no encontrado")); // Exception personalizada

        prod.setName(productoDTO.getName());
        prod.setCategory(productoDTO.getCategory());
        prod.setUnits(productoDTO.getUnits());
        prod.setPrice(productoDTO.getPrice());

        return Mapper.toDTO(repository.save(prod));
    }

    @Override
    public void deleteProducto(Long id) {
        if (!repository.existsById(id)) {
            throw new NotFoundException("Producto no encontrado para eliminar");
        }

        repository.deleteById(id);
    }
}
