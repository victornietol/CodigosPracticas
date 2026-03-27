# PATRONES DE DISEÑO

- ### Creational: Se encargan de cómo se crean los objetos, evitando dependencias rígidas. Separar la creación de objetos de su uso. Ejemplo: Singleton, Factory, Builder Prototype.
- ### Structural: Se enfocan en cómo organizar y relacionar clases y objetos para formar estructuras más grandes. Ayudan cuando se tienen muchas clases y es necesario adaptarlas, conectarlas, simplificar su interacción. Ejemplo: Adapter, Bridge, Decorator, Composite, Facade, Proxy.
- ### Behavioral: Definen cómo interactúan y se comunican los objetos. Ayudan en flujo de decisiones, comunicación entre objetos, manejo de eventos. Ejemplo: Observer, Strategy, Command, State, Chain of Responsability, Iterator.

- - -

- ## Behavioral

  - ### Chain of Responsability:
      Permite pasar una solicitud a través de una cadena de objetos, donde cada objeto decide como procesarla, pasarla al siguiente o ignorarla.

  - ### Observer:
    Define una relación uno a muchos donde Un objeto (Subject) notifica automáticamente a otros objetos (Observers) cuando cambia su estado.
    
