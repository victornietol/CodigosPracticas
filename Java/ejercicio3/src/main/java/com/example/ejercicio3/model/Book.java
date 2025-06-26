package com.example.ejercicio3.model;

import jakarta.persistence.*;

@Entity
public class Book {
    @Id
    private int idBook;

    @Column(name="book_title", length = 50, nullable = false)
    private String title;

    // Llave foranea
    @ManyToOne
    @JoinColumn(name="id_category", nullable = false)
    private Category category;

    @Column(nullable = false)
    private boolean enabled;

    public Book() {
    }

    public Book(int idBook, String title, Category category, boolean enabled) {
        this.idBook = idBook;
        this.title = title;
        this.category = category;
        this.enabled = enabled;
    }

    public int getIdBook() {
        return this.idBook;
    }

    public void setIdBook(int idBook) {
        this.idBook = idBook;
    }

    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public boolean isEnabled() {
        return this.enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    @Override
    public String toString() {
        return "Book{" +
                "idBook=" + idBook +
                ", title='" + title + '\'' +
                ", category=" + category +
                ", enabled=" + enabled +
                '}';
    }
}
