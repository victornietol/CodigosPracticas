package com.example.repasoSencillo_mysql.dto;

import lombok.*;

@AllArgsConstructor
@Getter @Setter
@ToString
@Builder
public class AutorDTO {
    private String nombre;
    private String apellidoP;
    private String apellidoM;
    private Boolean activo;
}
