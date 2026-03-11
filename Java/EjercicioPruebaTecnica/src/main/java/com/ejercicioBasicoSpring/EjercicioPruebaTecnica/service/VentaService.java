package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.DetalleVentaDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.VentaDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.exception.NotFoundException;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.mapper.Mapper;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.DetalleVenta;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Producto;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Sucursal;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Venta;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.repository.ProductoRepository;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.repository.SucursalRepository;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.repository.VentaRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class VentaService implements IVentaService {

    private final VentaRepository ventaRepo;
    private final ProductoRepository productoRepo;
    private final SucursalRepository sucursalRepo;

    public VentaService(
            VentaRepository ventaRepo,
            ProductoRepository productoRepo,
            SucursalRepository sucursalRepo
    ) {
        this.ventaRepo = ventaRepo;
        this.productoRepo = productoRepo;
        this.sucursalRepo = sucursalRepo;
    }

    @Override
    public List<VentaDTO> getVentas(VentaDTO ventaDTO) {
        List<Venta> ventas = ventaRepo.findAll();
        List<VentaDTO> ventasDTO = new ArrayList<>();
        VentaDTO dto;

        for(Venta v: ventas) {
            dto = Mapper.toDTO(v);
            ventasDTO.add(dto);
        }

        return ventasDTO;
    }

    @Override
    public VentaDTO createVenta(VentaDTO ventaDTO) {
        if (ventaDTO == null) throw new RuntimeException("Debe indicar la sucursal");

        if (ventaDTO.getIdSucursal() == null) throw new RuntimeException("Debe indicar la sucursal");

        if (ventaDTO.getDetail() == null || ventaDTO.getDetail().isEmpty())
            throw new RuntimeException("Debe incluir al menos un producto");

        // buscar sucursal
        Sucursal sucursal = sucursalRepo.findById(ventaDTO.getIdSucursal()).orElse(null);
        if (sucursal == null) {
            throw new NotFoundException("Sucursal no encontrada");
        }

        // crear venta
        Venta venta = new Venta();
        venta.setDate(ventaDTO.getDate());
        venta.setStatus(venta.getStatus());
        venta.setSucursal(sucursal);
        venta.setTotal(ventaDTO.getTotal());

        // lista de detalles
        // en los detalles estan los productos
        List<DetalleVenta> details = new ArrayList<>();
        for (DetalleVentaDTO detDTO: ventaDTO.getDetail()) {
            Producto p = productoRepo.findByName(detDTO.getNameProd()).orElse(null);
            if(p == null)
                throw new RuntimeException("Producto no encontrado: " + detDTO.getNameProd());

            DetalleVenta detalleVenta = new DetalleVenta();
            detalleVenta.setProducto(p);
            detalleVenta.setPrice(detDTO.getPrice());
            detalleVenta.setUnitsProd(detDTO.getUnitsProd());
            detalleVenta.setVenta(venta);

            details.add(detalleVenta);
        }
        venta.setDetail(details);

        ventaRepo.save(venta);

        return Mapper.toDTO(venta);
    }

    @Override
    public VentaDTO updateVenta(Long id, VentaDTO ventaDTO) {
        // buscar si existe la venta
        Venta v = ventaRepo.findById(id).orElse(null);
        if (v == null) throw new RuntimeException("Venta no encontrada");

        if (ventaDTO.getDate() != null) {
            v.setDate(ventaDTO.getDate());
        }

        if (ventaDTO.getStatus() != null) {
            v.setStatus(ventaDTO.getStatus());
        }

        if (ventaDTO.getTotal() != null) {
            v.setTotal(ventaDTO.getTotal());
        }

        if (ventaDTO.getIdSucursal() != null) {
            Sucursal sucursal = sucursalRepo.findById(ventaDTO.getIdSucursal()).orElse(null);
            if (sucursal == null) throw new NotFoundException("Sucursal no encontrada");
            v.setSucursal(sucursal);
        }

        ventaRepo.save(v);

        return Mapper.toDTO(v);
    }

    @Override
    public void deleteVenta(Long id) {
        Venta v = ventaRepo.findById(id).orElse(null);
        if (v == null) throw new RuntimeException("Venta no encontrada");
        ventaRepo.delete(v);
    }
}
