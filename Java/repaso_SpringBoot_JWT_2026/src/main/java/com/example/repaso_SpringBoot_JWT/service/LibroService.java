package com.example.repaso_SpringBoot_JWT.service;

import com.example.repaso_SpringBoot_JWT.model.Libro;
import com.example.repaso_SpringBoot_JWT.repository.LibroRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LibroService implements ILibroService{

    public final LibroRepository repository;

    public LibroService(LibroRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<Libro> getAll() {
        return repository.findAll();
    }
}
