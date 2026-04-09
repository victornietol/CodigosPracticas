package com.example.repaso_SpringBoot_JWT.auth;

import com.example.repaso_SpringBoot_JWT.auth.dto.AuthRequest;
import com.example.repaso_SpringBoot_JWT.auth.dto.AuthResponse;
import com.example.repaso_SpringBoot_JWT.auth.dto.RegisterRequest;
import com.example.repaso_SpringBoot_JWT.security.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService service;

    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@RequestBody RegisterRequest request) {
        return ResponseEntity.ok(service.register(request));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody AuthRequest request) {
        return ResponseEntity.ok(service.login(request));
    }

    @PostMapping("/refresh")
    public ResponseEntity<AuthResponse> refresh(@RequestHeader("Authorization") String header) {
        String refreshToken = header.substring(7);
        return ResponseEntity.ok(service.refresh(refreshToken));
    }
}
