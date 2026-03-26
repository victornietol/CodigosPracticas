package org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability;

import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.processor.CSRFAuthenticationProcessor;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.processor.JWTAuthenticationProcessor;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.processor.OAuthAuthenticationProcessor;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.provider.CSRFAuthProvider;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.provider.JWTAuthProvider;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.provider.OAuthProvider;

public class Main {
    public static void main(String[] args) {
        // se genera la cadena de responsabilidad
        AuthenticationProcessor jwt = new JWTAuthenticationProcessor(null);
        AuthenticationProcessor oaut = new OAuthAuthenticationProcessor(jwt);
        AuthenticationProcessor csrf = new CSRFAuthenticationProcessor(oaut);

        boolean csrfB = csrf.isAuthorized(new CSRFAuthProvider());
        boolean jwtB = csrf.isAuthorized(new JWTAuthProvider());
        boolean oauthB = csrf.isAuthorized(new OAuthProvider());

        System.out.println(csrfB + ", " + jwtB + ", " + oauthB);
    }
}
