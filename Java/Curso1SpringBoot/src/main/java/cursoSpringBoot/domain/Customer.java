package cursoSpringBoot.domain;

// Clase para clientes
public class Customer {
    private int id;
    private String nombre;
    private String username;
    private String password;

    public Customer(String username, int id, String nombre, String password) {
        this.username = username;
        this.id = id;
        this.nombre = nombre;
        this.password = password;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
