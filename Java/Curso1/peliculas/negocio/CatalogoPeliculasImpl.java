package mx.com.gm.peliculas.negocio;


import mx.com.gm.peliculas.datos.AccesoDatosImpl;
import mx.com.gm.peliculas.datos.IAccesoDatos;
import mx.com.gm.peliculas.domain.Pelicula;
import mx.com.gm.peliculas.excepciones.AccesoDatosEx;
import mx.com.gm.peliculas.excepciones.LecturaDatosEx;

/**
 *
 * @author nieto
 */
public class CatalogoPeliculasImpl implements ICatalogoPeliculas {
    
    private final IAccesoDatos datos; // Usar interfaz AccesoDatos

    public CatalogoPeliculasImpl() {
        // Utilizando la implementacion de la interface (AccesoDatosImpl) y asignandola a la variable definida como interface (IAccesoDatos)
        this.datos = new AccesoDatosImpl();
    }

    @Override
    public void agregarPelicula(String nombrePelicula) {
        Pelicula pelicula = new Pelicula(nombrePelicula);
        try {
            // Verificar que el archivo ya exista
            boolean anexar = this.datos.existe(NOMBRE_ARCHIVO);
            // Dependiendo de si existe se crea un nuevo archivo o no
            this.datos.escribir(pelicula, NOMBRE_ARCHIVO, anexar);
        } catch (AccesoDatosEx ex) {
            System.out.println("Ocurrio el error: "+ex.getMessage());
            ex.printStackTrace(System.out);
        }
    }

    @Override
    public void listarPeliculas() {
        int cont = 1;
        try {
            var peliculas = this.datos.listar(NOMBRE_ARCHIVO);
            System.out.println("Peliculas:");
            for(Pelicula pelicula: peliculas) {
                System.out.println((cont++)+". "+pelicula.getNombre());
            }
        } catch (LecturaDatosEx ex) {
            System.out.println("Ocurrio el error: "+ex.getMessage());
            ex.printStackTrace(System.out);
        }
    }

    @Override
    public void buscarPelicula(String buscar) {
       String resultado;
        try {
            resultado = this.datos.buscar(NOMBRE_ARCHIVO, buscar);
            System.out.println(resultado);
        } catch (LecturaDatosEx ex) {
            System.out.println("Ocurrio el error: "+ex.getMessage());
            ex.printStackTrace(System.out);
        }
    }

    @Override
    public void iniciarArchivo() {
        try {
            if(this.datos.existe(NOMBRE_ARCHIVO)) {
                this.datos.borrar(NOMBRE_ARCHIVO);
                this.datos.crear(NOMBRE_ARCHIVO);
            } else {
                this.datos.crear(NOMBRE_ARCHIVO);
            }
        } catch (AccesoDatosEx ex) {
            System.out.println("Ocurrio el error: "+ex.getMessage());
            ex.printStackTrace(System.out);
        }
    }
}
