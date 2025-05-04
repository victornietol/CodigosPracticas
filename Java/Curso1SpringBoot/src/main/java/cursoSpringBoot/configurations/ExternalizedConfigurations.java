package cursoSpringBoot.configurations;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration // Indica que es un archivo de configuracion
@ConfigurationProperties(prefix = "app") // Indica cuales propiedades de configuracion se van a utilizar, se debe asignar el prefijo asignado en el archivo de configuracion application.properties (en este caso 'app')
public class ExternalizedConfigurations {
    // Donde depositar las configuracion obtenidas con la notacion (se deben colocar en el mismo orden en el que se colocaron en el archivo de configuracion)
    private String name;
    private String version;
    private String autor;
    private String language;
    private String country;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @Override
    public String toString() {
        return "ExternalizedConfigurations{" +
                "name='" + this.name + '\'' +
                ", version='" + this.version + '\'' +
                ", autor='" + this.autor + '\'' +
                ", language='" + this.language + '\'' +
                ", country='" + this.country + '\'' +
                '}';
    }
}
