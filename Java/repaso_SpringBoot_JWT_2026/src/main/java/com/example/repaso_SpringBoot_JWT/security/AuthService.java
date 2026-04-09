package com.example.repaso_SpringBoot_JWT.security;

import com.example.repaso_SpringBoot_JWT.auth.dto.AuthRequest;
import com.example.repaso_SpringBoot_JWT.auth.dto.AuthResponse;
import com.example.repaso_SpringBoot_JWT.auth.dto.RegisterRequest;
import com.example.repaso_SpringBoot_JWT.model.Role;
import com.example.repaso_SpringBoot_JWT.model.User;
import com.example.repaso_SpringBoot_JWT.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    public AuthResponse register(RegisterRequest request) {

        User user = new User();
        user.setUsername(request.getUsername());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setEmail(request.getEmail());
        user.setRole(Role.valueOf(request.getRole().toUpperCase()));

        userService.create(user);

        String access = jwtService.generateToken(user);
        String refresh = jwtService.generateRefreshToken(user);

        return new AuthResponse(access, refresh);
    }

    public AuthResponse login(AuthRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );

        User user = userService.findByUsername(request.getUsername());

        return new AuthResponse(
                jwtService.generateToken(user),
                jwtService.generateRefreshToken(user)
        );
    }

    public AuthResponse refresh(String refreshToken) {
        String username = jwtService.extractUsername(refreshToken); // aqui ya se valida la firma en JwtService
        User user = userService.findByUsername(username);

        // validar integridad, expiración y tipo
        if (!jwtService.isTokenValid(refreshToken, user) || !jwtService.isRefreshToken(refreshToken)) {
            throw new BadCredentialsException("Invalid or expired refresh token");
        }

        return new AuthResponse(
                jwtService.generateToken(user),
                jwtService.generateRefreshToken(user)
        );
    }

}

