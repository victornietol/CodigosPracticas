## Patrones de diseño

No son código en si, son una forma de estructurar el código con el objetivo de resolver
un problema común.

Patrones a explorar:

* Plantilla (Template)
* Cadena de responsabilidad (Chain of Responsibility)
* Estrategia (Strategy)
* Proxy
* Constructor (Builder)
* Observador (Observer)
* Decorador (Decorator)

## Tipos de patrones

* **Creacionales** (como se crean los objetos)
  * Constructor (Builder) 
* **Estructurales** (se encargan de estructurar las piezas que componen a un elemento)
  * Proxy
  * Decorador
* **Comportamiento** (Se centran en lo que ejecutan)
  * Template
  * Chain of Responsibility
  * Strategy
  * Observer

## Objetivos generales
* Bajo acoplamiento
* Reutilización de código
* Flexibilidad
* Escalabilidad
* Eficiencia
* Estándar de buenas prácticas
* Favorece el testing
* Aumenta la calidad



## 1. Template
* Desacoplar código
* Reutilizar código

## 2. Chain of responsibility
En Spring Security se tienen los filtros

Objetivos:
* Reducir el acoplamiento
* Flexibilidad al permitir cambiar la responsabilidad
* Componer objetos que en su totalidad resuelven una unidad de trabajo
A tener en cuenta:
* Cada elementode la cadena de responsabilidad (manejador) tiene su propia implementacion
* Cada manejador hace referencia al siguiente manejador
* No deberían formarse ciclos recursivos

## 3. Strategy
Permite utilizar algoritmos de forma dinamica.
Ventajas:
* Cambiar un algoritmo o comportamiento en tiempo de ejecución.
* Clara separación de comportamientos, cada algoritmo representa una estrategia
* Principios SOLID: Open Closed. Podemos introducir nuevas estrategias sin alterar el código original
Desventajas:
* Se puede llegar a complicar al tener que introducir nuevas clases/intefaces

## 4. Proxy
Cargar un objeto pesado: imagenes, conexiones a BD (contexto de persistencia)
La carga de estos objetos se difiere todo lo posible.
Client -> Proxy -> Objeto
Ventajas:
* Permite gestionar el ciclo de vida del objeto sin que el cliente tenga nocion de ello.
* Principios SOLID: Open Closed. Podemos introducir objetos pesados.
Desventajas:
* Diferir la carga de un objeto no siempre será lo mejor si se necesita de inmediato
* Introducir nuevas clases puede dar lugar a complejidad.

## 5. Builder
Cuando una clase con muchos atributos y necesitamos múltiples formas de crear objetos haciendo
de constructores sobrecargados.
Tener toas las posibles combinaciones de constructores puede llegar a ser muy complejo de mantener.
Utiliza fluent programming style para lograr construir los objetos.
Devolver `this` al final de cada método setter.
Ventajas:
* Permite construir objetos paso a paso encadenando llamadas a metodos en una misma linea.
* Permite crear objetos cada vez con diferentes atributos sin necesidad de tener un constructor 
  para cada manera de crearlos.
* Principios SOLID: SRP. Una sola responsabilidad al aislar la fomra de construir el objeto a los clientes.
Desventajas:
* Requiere crear una nueva clase Builder lo cual puede añadir complejidad a la clase original.

## 6. Observer
Cuando se tiene una asociación de tipo "1" a muchos entre clases y queremos que cuando se 
actualice el objeto del lado "1" se notifique automáticamente a los objetos del lado "muchos"
Ejemplo: Un canal de YouTube sube nuevo video y se notifica automáticamente a todos los suscriptores.
Ventajas:
* Principios SOLID: Open Closed. Se pueden introducir nuevos objetos suscriptores
* Establecer relaciones entre objetos en tiempo de ejcución

## 7. Decorator
Agrega nueva funcionalidad a objetos existentes. Decorar objetos con nuevas funcionalidades.
Ventajas:
* Extender la funcionalidad de objetos existentes sin necesidad de utilizar herencia.
* Agregar nuevas responsabilidades o comportamientos a un objeto en tiempo de ejecución
* Múltiples comportamientos sobre un mismo por medio de utilizar más de un decorador a la vez.
* SRP Principio de una sola responsabilidad, cada decorador seria una clase y se centraria
  en una única responsabilidad.
Desventajas:
* Complejidad cuando hay muchos decoradores.
* Difícil eliminar un decorador que está dentro de otro decorador.
* El order en los decoradores puede ser importante y podría ser difícil tener que cambiarlo
