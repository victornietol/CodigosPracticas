package org.example.patronesDiseno.Factory;

public class RegularUser extends User {
    private String data;

    public RegularUser() {
    }

    public RegularUser(Integer id, String data) {
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
        return "RegularUser{" +
                "data='" + data + '\'' +
                '}';
    }
}
