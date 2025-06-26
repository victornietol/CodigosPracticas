package org.example.patronesDiseno;


public class Singleton {
    public static void main(String[] args) {
        /* Crear un solo objeto o instancia con un fin en especifico
        * Por ejemplo, una instancia de una base de datos para conectarse, una instancia
        * de un logger
        *  */

        // Sin Singleton
        // Se crean varios objetos para el mismo fin
        LoggerPlano logger1 = new LoggerPlano(); //
        LoggerPlano logger2 = new LoggerPlano();

        // Con Singleton
        LoggerSingleton loggerS = LoggerSingleton.getInstance();

    }


}

class LoggerPlano {
    // Clase ejemplo

    public LoggerPlano() {
        // Se inicializa
    }
     // Metodos ...
}

class LoggerSingleton {
    // Clase ejemplo
    private static LoggerSingleton loggerInstance; // Este deveria ser el mismo objeto siempre

    // Constructor privado para evitar instanciacion externa, solo se inicializa desde dentro
    private LoggerSingleton() {
        // Se inicializa
    }

    public static LoggerSingleton getInstance() {
        if (loggerInstance==null) { // Si no hay instancia entonces se crea una
            loggerInstance = new LoggerSingleton();
        }
        return loggerInstance; // Si hay intancia se regresa la creada previamente
    }
}