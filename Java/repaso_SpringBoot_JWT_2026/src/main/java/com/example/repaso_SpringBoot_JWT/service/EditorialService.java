package com.example.repaso_SpringBoot_JWT.service;

import com.example.repaso_SpringBoot_JWT.model.Editorial;
import com.example.repaso_SpringBoot_JWT.repository.EditorialRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EditorialService implements IEditorialService{

    private final EditorialRepository repository;

    public EditorialService(EditorialRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<Editorial> getAll() {
        return repository.findAll();
    }
}
