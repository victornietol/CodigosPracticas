package com.example.ejercicio3.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Category {

    @Id
    private Integer idCategory;

    @Column(name="name", length = 50, nullable = false)
    private String name;

    public Category() {
    }

    public Category(Integer idCategory, String name) {
        this.idCategory = idCategory;
        this.name = name;
    }

    public Integer getIdCategory() {
        return idCategory;
    }

    public void setIdCategory(Integer idCategory) {
        this.idCategory = idCategory;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Category{" +
                "idCategory=" + idCategory +
                ", name='" + name + '\'' +
                '}';
    }
}
