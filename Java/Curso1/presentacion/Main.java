package mx.com.gm.presentacion;

import java.util.Scanner;
import mx.com.gm.peliculas.negocio.*;

/**
 *
 * @author nieto
 */
public class Main {
    private final static Scanner scanner1 = new Scanner(System.in);
    
    public static void main(String[] args) {
        int opc;
        do {
            try {
                opc = menu(); // Mostrar menu y seleccionar una opcion
                ejecutarOpc(opc); // Ejecutar la opcion seleccionada
            } catch(Exception e) {
                System.out.println("Error: El valor introducido debe ser numerico.");
                opc = 0;
            }
        } while (opc != 5);
    }
    
    private static int menu() {
        int opc;
        System.out.print("""
                           Elige el numero correspondiente a opcion:
                             1. Iniciar catalogo peliculas.
                             2. Agregar pelicula.
                             3. Listar peliculas.
                             4. Buscar pelicula.
                             5. Salir.
                           Opcion: """);
        opc = Integer.parseInt(scanner1.nextLine());
        return opc;
    }
    
    private static void ejecutarOpc(int opc) {
        ICatalogoPeliculas catalogo = new CatalogoPeliculasImpl(); // Esta interface sirve para hacer las operaciones en el catalogo
        String nombrePelicula;
        switch (opc) {
            case 1:
                catalogo.iniciarArchivo();
                System.out.println("");
                break;
            case 2:
                System.out.print("Nombre de la pelicula: ");
                nombrePelicula = Main.scanner1.nextLine();
                catalogo.agregarPelicula(nombrePelicula);
                System.out.println("");
                break;
            case 3:
                catalogo.listarPeliculas();
                System.out.println("");
                break;
            case 4:
                System.out.print("Nombre de la pelicula: ");
                nombrePelicula = Main.scanner1.nextLine();
                catalogo.buscarPelicula(nombrePelicula);
                System.out.println("");
                break;
            case 5:
                break;
            default:
                System.out.println("Opcion invalida: "+opc);
                System.out.println("");
        }
    }
}