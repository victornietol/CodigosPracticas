package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.ProductoDTO;

import java.util.List;

public interface IProductoService {
    List<ProductoDTO> getProductos();
    ProductoDTO getById(Long id);
    ProductoDTO createProducto(ProductoDTO productoDTO);
    ProductoDTO updateCompleteProducto(Long id, ProductoDTO productoDTO);
    void deleteProducto(Long id);
}
