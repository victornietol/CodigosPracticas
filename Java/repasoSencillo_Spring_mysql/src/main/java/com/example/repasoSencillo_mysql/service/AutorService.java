package com.example.repasoSencillo_mysql.service;

import com.example.repasoSencillo_mysql.dto.AutorDTO;
import com.example.repasoSencillo_mysql.exceptions.ResourceNotFoundException;
import com.example.repasoSencillo_mysql.model.AutorModel;
import com.example.repasoSencillo_mysql.repository.AutorRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AutorService implements IAutorService {

    private final AutorRepository repository;

    public AutorService(AutorRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<AutorModel> getAll() {
        return repository.findAll();
    }

    @Override
    public AutorModel getById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Recurso no encontrado"));
    }

    @Override
    public AutorModel create(AutorDTO autor) {
        AutorModel newAutor = AutorModel.builder()
                .nombre(autor.getNombre())
                .apellidoP(autor.getApellidoP())
                .apellidoM(autor.getApellidoM())
                .activo(true)
                .build();
        return repository.save(newAutor);
    }

    @Override
    @Transactional
    public AutorModel update(Long id, AutorDTO autorDTO) {
        AutorModel autorModel = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Recurso no encontrado para actualizar."));

        // se actualizan los campos necesarios y el objeto al finalizar la funcion gracias a @Transactional
        autorModel.setNombre(autorDTO.getNombre());
        autorModel.setApellidoP(autorDTO.getApellidoP());
        autorModel.setApellidoM(autorDTO.getApellidoM());
        autorModel.setActivo(autorDTO.getActivo());

        return autorModel;
    }

    @Override
    public void deleteById(Long id) {
        AutorModel autor = repository.findById(id)
                        .orElseThrow(() -> new ResourceNotFoundException("Recurso no encontrado para eliminacion."));
        repository.delete(autor);
    }
}
