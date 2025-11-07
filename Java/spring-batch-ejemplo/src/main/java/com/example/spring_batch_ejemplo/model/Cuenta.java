package com.example.spring_batch_ejemplo.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Cuenta {

    @Id
    private Long id;
    private String cuenta;
    private String estatus;
}
