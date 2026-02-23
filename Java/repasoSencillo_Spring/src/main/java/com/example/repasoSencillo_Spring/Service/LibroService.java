package com.example.repasoSencillo_Spring.Service;

import com.example.repasoSencillo_Spring.Entity.LibroEntity;
import com.example.repasoSencillo_Spring.Repository.LibroRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class LibroService {

    private final LibroRepository repository;

    public LibroService(LibroRepository repository) {
        this.repository = repository;
    }

    public List<LibroEntity> getAll() {
        return repository.findAll();
    }

    public Optional<LibroEntity> getById(Long id) {
        return repository.findById(id);
    }

    public LibroEntity save(LibroEntity libro) {
        return repository.save(libro);
    }

    public boolean existById(Long id) {
        return repository.existsById(id);
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
