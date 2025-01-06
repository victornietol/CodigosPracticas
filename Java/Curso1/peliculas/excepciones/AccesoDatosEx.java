package mx.com.gm.peliculas.excepciones;

/**
 *
 * Crear excepcion personalizada para errores al acceder a los datos
 */
public class AccesoDatosEx extends Exception {

    public AccesoDatosEx(String mensaje) {
        super(mensaje);
    }
    
}
