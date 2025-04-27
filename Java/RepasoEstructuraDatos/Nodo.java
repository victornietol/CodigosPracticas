package RepasoEstructuraDatos;

public class Nodo {
    private Object valor;
    private Nodo sig;

    public Object getValor() {
        return this.valor;
    }

    public void setValor(Object valor) {
        this.valor = valor;
    }

    public Nodo getSig() {
        return this.sig;
    }

    public void setSig(Nodo nodo) {
        this.sig = nodo;
    }

    @Override
    public String toString() {
        return "Nodo{" + "valor=" + valor + ", sig=" + sig + '}';
    }
      
}
