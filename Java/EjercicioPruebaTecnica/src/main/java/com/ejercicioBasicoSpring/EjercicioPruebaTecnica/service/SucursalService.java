package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.SucursalDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.exception.NotFoundException;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.mapper.Mapper;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Sucursal;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.repository.SucursalRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SucursalService implements ISucursalService {

    private final SucursalRepository repository;

    public SucursalService(SucursalRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<SucursalDTO> getSucursales() {
        return repository.findAll()
                .stream()
                .map(Mapper::toDTO)
                .toList();
    }

    @Override
    public SucursalDTO createSucursal(SucursalDTO sucursalDTO) {
        Sucursal sucursal = Sucursal.builder()
                .name(sucursalDTO.getName())
                .address(sucursalDTO.getAddress())
                .build();

        return Mapper.toDTO(repository.save(sucursal));
    }

    @Override
    public SucursalDTO updateSucursal(Long id, SucursalDTO sucursalDTO) {
        Sucursal sucursal = repository.findById(id)
                .orElseThrow(() -> new NotFoundException("Sucursal no encontrada"));

        sucursal.setName(sucursalDTO.getName());
        sucursal.setAddress(sucursalDTO.getAddress());

        return Mapper.toDTO(repository.save(sucursal));
    }

    @Override
    public void deleteSucursal(Long id) {
        if (!repository.existsById(id)) {
            throw new NotFoundException("Sucursal no encontrada");
        }

        repository.deleteById(id);
    }
}
