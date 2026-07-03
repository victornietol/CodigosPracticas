package com.example.repasoSencillo_mysql.service;

import com.example.repasoSencillo_mysql.dto.AutorDTO;
import com.example.repasoSencillo_mysql.model.AutorModel;

import java.util.List;

public interface IAutorService {
    public List<AutorModel> getAll();
    public AutorModel getById(Long id);
    public AutorModel create(AutorDTO autor);
    public AutorModel update(Long id, AutorDTO autorDTP);
    public void deleteById(Long id);
}
