package RepasoEstructuraDatos;

/**
 *
 * @author Victor
 */
public class ListaDoblementeLigada {
    private Nodo2 nodoInicial = null;
    private Nodo2 nodoFinal = null;
    private int numElementos = 0;

    public ListaDoblementeLigada() {
    }
    
    public boolean insertarInicio(Nodo2 nodo) {
        if(this.numElementos<1) {
            // Si es primer elemento a introducir
            ++this.numElementos;
            this.nodoInicial = nodo;
        } else {
            // Si hay mas de un elemento
            ++this.numElementos;
            Nodo2 nodoInicialPasado = this.nodoInicial;
            this.nodoInicial = nodo;
            this.nodoInicial.setAnt(null);
            this.nodoInicial.setSig(nodoInicialPasado);
            nodoInicialPasado.setAnt(this.nodoInicial);
        }
        
        // Austando el nodo final
        if(this.numElementos == 1) {
            this.nodoFinal = this.nodoInicial;
        }
        
        return true;
    }
    
    public int insertarFinal(Nodo2 nodo) { // Regresa el indice del elemento agregado
        // Verificando si hay mas de un elemento
        if(this.numElementos==0) {
            this.insertarInicio(nodo);
        } else {
            ++this.numElementos;
            nodo.setAnt(this.nodoFinal);
            this.nodoFinal.setSig(nodo);
            this.nodoFinal = nodo;
        }
        return this.numElementos-1;
    }
    
    public int insertarIntermedio(Nodo2 nodo, int indiceInsercion) {
        if(indiceInsercion==0) {
            // Insertar al inicio
            this.insertarInicio(nodo);
            return 0;
        } else if (indiceInsercion==this.numElementos) {
            // Insertar al final
            this.insertarFinal(nodo);
            return indiceInsercion;
        } else if (indiceInsercion<0 || indiceInsercion>(this.numElementos-1)) {
            // No existe el indice
            return -1;
        } else {
            // Insertar
            // Inicia la busqueda en el segundo nodo
            return this.insertar(nodo, this.nodoInicial, this.nodoInicial.getSig(), 1, indiceInsercion);
        }
    }
    
    private int insertar(Nodo2 nodoInsercion, Nodo2 nodoAnterior, Nodo2 nodoActual, int indiceActual, int indiceObjetivo) { // Recorrer hasta insertar
        if(indiceActual==indiceObjetivo) {
            // Se inserta al llegar al indice y se regresa su valor
            nodoAnterior.setSig(nodoInsercion);
            nodoInsercion.setAnt(nodoAnterior);
            nodoInsercion.setSig(nodoActual);
            nodoActual.setAnt(nodoInsercion);
            return indiceActual;
        } else {
            // Seguir buscando
            ++indiceActual;
            return this.insertar(nodoInsercion, nodoActual, nodoActual.getSig(), indiceActual, indiceObjetivo);
        }
    }
    
    public Nodo2 obtenerNodoInicial() {
        return this.nodoInicial;
    }
    
    public String recorrerLista(Nodo2 nodo) {
        if(nodo.getSig()==null) {
            return "\n" + nodo.getAnt().getValor() + " <- " + nodo.getValor() + " -> null";
        } else {
            return "\n" + (nodo.getAnt()==null ? null : nodo.getAnt().getValor()) + " <- " + nodo.getValor() + " -> " + nodo.getSig().getValor() + recorrerLista(nodo.getSig());
        }
    }
    
    public String recorrerListaLineal(Nodo2 nodo) {
        if(nodo.getSig()==null) {
            return nodo.getValor() + " <-> null";
        } else {
            return nodo.getValor() + " <-> " + recorrerListaLineal(nodo.getSig());
        }
    }

    @Override
    public String toString() {
        return "ListaDoblementeLigada{" + "nodoInicial=" + nodoInicial + ", nodoFinal=" + nodoFinal + ", numElementos=" + numElementos + '}';
    }
}
