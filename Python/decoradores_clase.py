import inspect

def decorador_repr(cls):
    # Se revisan los atributos
    atributos = vars(cls)
    #for nombre, atributo in atributos.items():

    # Revisar si se ha sobreescrito el metodo __init__
    if "__init__" not in atributos:
        raise TypeError(f"{cls.__name__} no se ha sobreescirto el metodo __init__")
    
    # Revisar la firma del metodo __init__ para verificar los paramtros del metodo
    firma_init = inspect.signature(cls.__init__)

    # Recuperar los parametros del metodo __init__ menos el primero (self)
    parametros_init = list(firma_init.parameters)[1:]

    # Verificar si cada parametro tiene su metodo "property"
    for parametro in parametros_init:
        es_metodo = isinstance(atributos.get(parametro), property)
        if(not es_metodo):
            raise TypeError("No existe el metodo property para el metodo: '{parametro}'")
        
    # Crear el metodo __repr__ dinamicamente
    def metodo_repr(self):
        # Obtener el nombre de la clase
        nombre_clase = self.__class__.__name__
        # Obtener el nombre de las propiedad y su valor dinamicamente
        # Expresion generadora
        generador_arg = (f"{nombre}={getattr(self, nombre)!r}" for nombre in parametros_init)
        # Lista del generador
        lista_arg = list(generador_arg)
        # Crear la cadena a partir de la lista de argumentos
        argumentos = ", ".join(lista_arg)
        # Crear la forma del metodo
        resultado = f"{nombre_clase} ({argumentos})"
        return resultado

    # Agregar dinamicamente el metodo repr a la clase
    setattr(cls, "__repr__", metodo_repr)

    return cls # Debe regresar el objeto de la clase a crear

@decorador_repr
class Persona:
    def __init__(self, nombre, apellido):
        self.__nombre = nombre
        self.__apellido = apellido

    @property
    def nombre(self):
        return self.__nombre
    
    @property
    def apellido(self):
        return self.__apellido
    


######################## Dataclass
# Crear clases con dataclass

from dataclasses import dataclass
from typing import ClassVar

@dataclass(eq=True, frozen=True)
class Domicilio:
    calle: str
    numero: int = 0

@dataclass(eq=True, frozen=True) # Se le pueden pasar parametros al decorador para indicar ciertos comportamientos, por ejemplo dataclass(frozen=True) con lo que no se pueden modificar los valores del objeto
class Persona_2:
    nombre: str
    apellido: str
    domicilio: Domicilio # Objeto de la clase Domicilio
    contador_personas: ClassVar[int] = 0 # Variable de clase

    def __post__init__(self):
        if not self.nombre:
            raise ValueError(f"Valor de nombre vacio: {self.nombre}")



#################### Pruebas


persona1 = Persona("Juan","Hernandez")
print(persona1)


persona2 = Persona_2("Pedro", "Nieto", Domicilio("Universidad", 120))
print(f"{persona2!r}")