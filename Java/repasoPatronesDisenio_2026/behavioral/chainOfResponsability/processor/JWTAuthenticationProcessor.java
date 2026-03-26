package org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.processor;

import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.AuthenticationProcessor;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.AuthenticationProvider;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.provider.JWTAuthProvider;

public class JWTAuthenticationProcessor extends AuthenticationProcessor {

    public JWTAuthenticationProcessor(AuthenticationProcessor next) {
        super(next);
    }

    @Override
    public boolean isAuthorized(AuthenticationProvider provider)  {
        if(provider instanceof JWTAuthProvider) {
            System.out.println("Es JWTAuthProvider");
            return true;
        }

        return next.isAuthorized(provider);
    }

}
