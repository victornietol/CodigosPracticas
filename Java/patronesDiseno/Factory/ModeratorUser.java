package org.example.patronesDiseno.Factory;

public class ModeratorUser extends User {
    private String data;

    public ModeratorUser() {
    }

    public ModeratorUser(Integer id, String data) {
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
        return "ModeratorUser{" +
                "data='" + data + '\'' +
                '}';
    }
}
