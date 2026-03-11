package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.ProductoDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.exception.NotFoundException;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.mapper.Mapper;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Producto;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.repository.ProductoRepository;
import org.springframework.stereotype.Service;

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
    public ProductoDTO createProducto(ProductoDTO productoDTO) {
        Producto prod = Producto.builder()
                .name(productoDTO.getName())
                .category(productoDTO.getCategory())
                .price(productoDTO.getPrice())
                .units(productoDTO.getUnits())
                .build();

        return Mapper.toDTO(repository.save(prod));
    }

    @Override
    public ProductoDTO updateProducto(Long id, ProductoDTO productoDTO) {
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
            throw new NotFoundException("Producto no encontrado para eliminar")
        }

        repository.deleteById(id);
    }
}
