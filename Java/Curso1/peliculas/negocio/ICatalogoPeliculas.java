package mx.com.gm.peliculas.negocio;

/**
 *
 * @author nieto
 */
public interface ICatalogoPeliculas {
    String NOMBRE_ARCHIVO = "peliculas.txt";
    
    public void agregarPelicula(String nombrePelicula);
    public void listarPeliculas();
    public void buscarPelicula(String buscar);
    public void iniciarArchivo();
    
}
