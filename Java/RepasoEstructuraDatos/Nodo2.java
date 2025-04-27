package RepasoEstructuraDatos;

public class Nodo2 {
    private Object valor;
    private Nodo2 sig = null;
    private Nodo2 ant = null;

    public Nodo2(Object valor) {
        this.valor = valor;
    }

    public Object getValor() {
        return this.valor;
    }

    public void setValor(Object valor) {
        this.valor = valor;
    }

    public Nodo2 getSig() {
        return this.sig;
    }

    public void setSig(Nodo2 nodo) {
        this.sig = nodo;
    }
    
    public Nodo2 getAnt() {
        return this.ant;
    }

    public void setAnt(Nodo2 nodo) {
        this.ant = nodo;
    }

    @Override
    public String toString() {
        return "Nodo2{" + 
                "valor=" + this.valor + 
                ", ant=" + (this.ant != null ? this.ant.getValor() : null) + 
                ", sig=" + (this.sig != null ? this.sig.getValor() : null) + 
                "}";
    }
      
}