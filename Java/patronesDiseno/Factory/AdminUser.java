package org.example.patronesDiseno.Factory;

public class AdminUser extends User {
    private String data;

    public AdminUser() {
    }

    public AdminUser(Integer id, String data) {
        super(id);
        this.data = data;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "AdminUser{" +
                "data='" + data + '\'' +
                '}';
    }
}
