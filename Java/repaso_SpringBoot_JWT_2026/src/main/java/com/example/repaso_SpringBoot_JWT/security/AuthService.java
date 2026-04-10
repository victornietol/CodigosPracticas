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
        if (user.getRole() == null) { // asignar rol por defecto
            user.setRole(Role.CLIENTE);
        } else {
            user.setRole(Role.valueOf(request.getRole().toUpperCase()));
        }

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
        try {
            if (!jwtService.isRefreshToken(refreshToken)) {
                throw new BadCredentialsException("Invalid token type");
            }

            String username = jwtService.extractUsername(refreshToken);
            User user = userService.findByUsername(username);

            if (user == null || !jwtService.isTokenValid(refreshToken, user)) {
                throw new BadCredentialsException("Invalid or expired refresh token");
            }

            return new AuthResponse(
                    jwtService.generateToken(user),
                    jwtService.generateRefreshToken(user)
            );

        } catch (Exception e) {
            throw new BadCredentialsException("Invalid or expired refresh token");
        }
    }

}

