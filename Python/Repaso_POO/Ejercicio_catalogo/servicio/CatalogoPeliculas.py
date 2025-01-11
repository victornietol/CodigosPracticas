from dominio.Pelicula import Pelicula
import os

# Solo realiza operaciones sobre el archivo "peliculas.txt"
class CatalogoPeliculas:
    ruta = ""

    def __init__(self, ruta:str):
        CatalogoPeliculas.ruta = ruta

    @staticmethod
    def agregar_pelicula(pelicula: Pelicula):
        with open(CatalogoPeliculas.ruta, "a", encoding="utf8") as archivo:
            archivo.write(f"{pelicula.nombre}\n")

    @staticmethod
    def listar_peliculas():
        with open(CatalogoPeliculas.ruta, "r", encoding="utf8") as archivo:
            print(archivo.read())


    @staticmethod
    def eliminar():
        os.remove(CatalogoPeliculas.ruta)