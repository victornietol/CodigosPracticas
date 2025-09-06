package com.example.spring_patrones_disenio.behavioral.chainOfResponsibility;

import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.processor.CSRFAuthenticationProcessor;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.processor.JWTAuthenticationProcessor;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.processor.OAuthAuthenticationProcessor;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.provider.CSRFAuthProvider;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.provider.JWTAuthProvider;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.provider.OAuthProvider;

public class Main {
    public static void main(String[] args) {

        // Asi se genera la cadena de responsabilidad
        AuthenticationProcessor jwt = new JWTAuthenticationProcessor(null);
        AuthenticationProcessor oaut = new OAuthAuthenticationProcessor(jwt);
        AuthenticationProcessor csrf = new CSRFAuthenticationProcessor(oaut);

        csrf.isAuthorized(new CSRFAuthProvider());
        csrf.isAuthorized(new JWTAuthProvider());
        csrf.isAuthorized(new OAuthProvider());
    }
}
