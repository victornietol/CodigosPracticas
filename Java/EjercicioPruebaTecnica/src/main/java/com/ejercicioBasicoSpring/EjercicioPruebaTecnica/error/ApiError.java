package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.error;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Setter @Getter
@AllArgsConstructor
@ToString
public class ApiError {
    private int status;
    private String message;
    private LocalDateTime timestamp;
}
