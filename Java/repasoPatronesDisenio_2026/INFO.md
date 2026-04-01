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
    
  - ### Strategy:
    El patrón Strategy define una familia de algoritmos, los encapsula y los hace intercambiables. Permite cambiar el comportamiento de un objeto en tiempo de ejecución sin modificar su código.
  
  - ### Template:
    El patrón Template Method define el esqueleto de un algoritmo en una clase base, pero permite que las subclases redefinan ciertos pasos sin cambiar la estructura general. La clase padre controla el flujo, las hijas personalizan detalles. 
  
- - -

- ## Creational

  - ### Builder:
    El patrón Builder permite construir objetos complejos paso a paso, separando como se construyen del que se construye. En lugar de tener un constructor gigante, construyes el objeto de forma controlada y legible.
  
  - ### Factory:
    El patrón Factory define una forma de crear objetos sin especificar exactamente qué clase concreta se va a instanciar. En lugar de usar "new", se delega la creación a una "fábrica" a la que se le indica o pide que objeto debe devolver.
  
  - ### Singleton:
    Garantiza que una clase tenga una única instania y proporcione un punto global de acceso a ella. Es como un objeto único compartido en toda la aplicación.
  
- - -

- ## Structural

  - ### Adaptaer:
    permite que dos clases incompatibles trabajen juntas. Convierte la interfaz de una clase en otra que el cliente espera.
  
  