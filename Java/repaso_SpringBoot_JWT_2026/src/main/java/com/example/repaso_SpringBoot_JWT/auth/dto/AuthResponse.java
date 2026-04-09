package com.example.repaso_SpringBoot_JWT.auth.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter @AllArgsConstructor
public class AuthResponse {
    private String accessToken;
    private String refreshToken;
}
