package com.example.repaso_SpringBoot_JWT.service;

import com.example.repaso_SpringBoot_JWT.model.Autor;
import com.example.repaso_SpringBoot_JWT.repository.AutorRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AutorService implements IAutorService {

    private final AutorRepository repository;

    public AutorService(AutorRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<Autor> getAll() {
        return repository.findAll();
    }
}
