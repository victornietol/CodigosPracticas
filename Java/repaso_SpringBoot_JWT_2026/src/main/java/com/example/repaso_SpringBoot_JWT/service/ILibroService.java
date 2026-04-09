package com.example.repaso_SpringBoot_JWT.service;

import com.example.repaso_SpringBoot_JWT.model.Libro;

import java.util.List;

public interface ILibroService {
    public List<Libro> getAll();
}
