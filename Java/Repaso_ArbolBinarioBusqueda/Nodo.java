package org.example;

public class Nodo {
    private Integer valor;
    private Nodo izq;
    private Nodo der;

    public Nodo(Integer valor) {
        this.valor = valor;
    }

    public Integer getValor() {
        return valor;
    }

    public void setValor(Integer valor) {
        this.valor = valor;
    }

    public Nodo getIzq() {
        return izq;
    }

    public void setIzq(Nodo izq) {
        this.izq = izq;
    }

    public Nodo getDer() {
        return der;
    }

    public void setDer(Nodo der) {
        this.der = der;
    }

    @Override
    public String toString() {
        return "Nodo{" +
                "valor=" + valor +
                ", izq=" + izq +
                ", der=" + der +
                '}';
    }
}
