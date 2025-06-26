package com.example.ejercicio3.service.impl;

import com.example.ejercicio3.model.Category;
import com.example.ejercicio3.repository.CategoryRepository;
import com.example.ejercicio3.service.CategoryService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {


    private CategoryRepository repo;

    // Inyeccion de dependencias por constructor
    public CategoryServiceImpl(CategoryRepository repo) {
        this.repo = repo;
    }

    @Override
    public Category save(Category category) {
        return repo.save(category);
    }

    @Override
    public Category update(Integer id, Category category) {
        category.setIdCategory(id); // id que se indico en la URL
        return repo.save(category);
    }

    @Override
    public List<Category> findAll() {
        return repo.findAll();
    }

    @Override
    public Category findById(Integer id) {
        return repo.findById(id).orElse(new Category(999,"no category"));
    }

    @Override
    public void delete(Integer id) {
        repo.deleteById(id);
    }
}
