package RepasoEstructuraDatos;


public class RepasoEstructurasDatos {
    public static void main(String[] args) {
        Nodo2 n1 = new Nodo2(1);
        Nodo2 n2 = new Nodo2(2);
        Nodo2 n3 = new Nodo2(3);
        Nodo2 n4 = new Nodo2(4);
        Nodo2 n5 = new Nodo2(5);
        
        ListaDoblementeLigada listaDL = new ListaDoblementeLigada();
        listaDL.insertarInicio(n1);
        listaDL.insertarInicio(n2);
        listaDL.insertarInicio(n3);
        System.out.println(listaDL);
        String recorrer = listaDL.recorrerLista(listaDL.obtenerNodoInicial());
        System.out.println(recorrer);
        
        listaDL.insertarFinal(n4);
        System.out.println(listaDL);
        recorrer = listaDL.recorrerLista(listaDL.obtenerNodoInicial());
        System.out.println(recorrer);
        
        listaDL.insertarIntermedio(n5, 2);
        System.out.println(listaDL);
        recorrer = listaDL.recorrerLista(listaDL.obtenerNodoInicial());
        System.out.println(recorrer);
    }
}
