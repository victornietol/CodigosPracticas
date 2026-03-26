package org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.processor;

import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.AuthenticationProcessor;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.AuthenticationProvider;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.provider.OAuthProvider;

public class OAuthAuthenticationProcessor extends AuthenticationProcessor {

    public OAuthAuthenticationProcessor(AuthenticationProcessor next) {
        super(next);
    }

    @Override
    public boolean isAuthorized(AuthenticationProvider provider) {
        // logica de este procesor, aqui termina en caso de que se acaben
        // las comprobaciones, de lo contrario, saltara al siguiente procesor
        if(provider instanceof OAuthProvider) {
            System.out.println("Es OAuthProvider");
            return true;
        }

        // llama al siguiente procesor
        return next.isAuthorized(provider);
    }
}
