from servicio.CatalogoPeliculas import CatalogoPeliculas as CP
from dominio.Pelicula import Pelicula


def seleccionar_opc() -> int:
    try:
        opcion = int(input("""Elige una opcion:
        1) Agregar pelicula
        2) Listar peliculas
        3) Eliminar archivo de peliculas
        4) Salir
    """))
    except Exception as e:
        print(f"Ocurrio el error: {e}")
        opcion = 0
    return opcion

def ejecutar_opc(opcion: int):
    if(opcion==1):
       agregar_pelicula()
    elif(opcion==2):
        listar_peliculas()
    elif(opcion==3):
        eliminar_archivo()

def agregar_pelicula():
    nombre = input("Nombre de la pelicula: ")
    pelicula = Pelicula(nombre)
    CP.agregar_pelicula(pelicula)

def listar_peliculas():
    CP.listar_peliculas()

def eliminar_archivo():
    CP.eliminar()
    print("Se elimino la pelicula\n")


if __name__ == "__main__":
    ejecutar = True
    nombre_archivo = "peliculas.txt"
    ruta = "C:\\Victor\\CodigosGenerales\\Python\\Repaso_POO\\Ejercicio_catalogo\\"
    CP.ruta = (ruta+nombre_archivo) # Asignando la ruta
    
    while(ejecutar==True):
        opcion = seleccionar_opc()
        if(opcion==4):
            ejecutar = False
            print("Ejecucion terminada.")
        elif(opcion>0 and opcion<4):
            ejecutar_opc(opcion)
        else:
            print("Opcion invalida, vuelva a intentarlo.\n")
