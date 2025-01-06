package mx.com.gm.peliculas.datos;

import java.io.*;
import java.util.*;
import mx.com.gm.peliculas.domain.Pelicula;
import mx.com.gm.peliculas.excepciones.*;

/**
 *
 * @author nieto
 */
public class AccesoDatosImpl implements IAccesoDatos {
    
    @Override
    public boolean existe(String nombreArchivo) { // RUTA esta definido en la interface
        File archivo = new File(RUTA+nombreArchivo); // Verificar que el archivo exista
        return archivo.exists();
    }

    @Override
    public List<Pelicula> listar(String nombre) throws LecturaDatosEx {
        File archivo = new File(RUTA+nombre);
        List<Pelicula> listaPeliculas = new ArrayList<>();
        try {
            BufferedReader br = new BufferedReader(new FileReader(archivo));
            String linea;
            while((linea=br.readLine()) != null) {
                    listaPeliculas.add(new Pelicula(linea));
            }
            br.close();
        } catch (FileNotFoundException ex) {
            ex.printStackTrace(System.out);
            throw new LecturaDatosEx("Error al listar peliculas: "+ex.getMessage());
        } catch (IOException ex) {
            ex.printStackTrace(System.out);
            throw new LecturaDatosEx("Error al listar peliculas: "+ex.getMessage());
        }
        return listaPeliculas;
    }

    @Override
    public void escribir(Pelicula pelicula, String nombreArchivo, boolean anexar) throws EscrituraDatosEx {
        File archivo = new File(RUTA+nombreArchivo);
        try {
            var salida = new PrintWriter(new FileWriter(archivo, anexar));
            salida.println(pelicula.getNombre());
            salida.close();
            System.out.println("Se ha agregado la pelicula");
        } catch (IOException ex) {
            ex.printStackTrace(System.out);
            throw new EscrituraDatosEx("Error al escribir peliculas: "+ex.getMessage());
        }
    }    
        
    @Override
    public String buscar(String nombreArchivo, String buscar) throws LecturaDatosEx {
        File archivo = new File(RUTA+nombreArchivo);
        String resultado = null;
        try {
            BufferedReader br = new BufferedReader(new FileReader(archivo));
            String pelicula;
            int linea = 1;
            while((pelicula=br.readLine()) != null) {
                if(pelicula.equals(buscar)) {
                    resultado = pelicula+". Encontrado en la linea: "+linea;
                    break;
                } else {
                    resultado = "No se encontro la pelicula.";
                }
                linea++;
            }
            br.close();
        } catch (FileNotFoundException ex) {
            ex.printStackTrace(System.out);
            throw new LecturaDatosEx("Error al listar peliculas: "+ex.getMessage());
        } catch (IOException ex) {
            ex.printStackTrace(System.out);
            throw new LecturaDatosEx("Error al listar peliculas: "+ex.getMessage());
        }
        return resultado;
    }

    @Override
    public void crear(String nombreArchivo) throws AccesoDatosEx {
        File archivo = new File(RUTA+nombreArchivo);
        try {
            var salida = new PrintWriter(new FileWriter(archivo));
            salida.close();
            System.out.println("Se ha creado el archivo.");
        } catch (IOException ex) {
            ex.printStackTrace(System.out);
            throw new AccesoDatosEx("Error al listar peliculas: "+ex.getMessage());
        }
    }

    @Override
    public void borrar(String nombreArchivo) {
        File archivo = new File(RUTA+nombreArchivo);
        if(archivo.exists()) {
            archivo.delete();
            System.out.println("Archivo borrado.");
        } else {
            System.out.println("El archivo no existe.");
        }
    }
    
}
