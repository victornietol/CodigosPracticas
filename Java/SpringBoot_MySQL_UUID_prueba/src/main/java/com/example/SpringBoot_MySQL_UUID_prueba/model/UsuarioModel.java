package com.example.SpringBoot_MySQL_UUID_prueba.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;

import java.util.UUID;

@Entity(name = "usuario")
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@ToString
@Builder
public class UsuarioModel {

    @Id @GeneratedValue(strategy = GenerationType.UUID)
    private UUID uuid;

    private String username;
}
