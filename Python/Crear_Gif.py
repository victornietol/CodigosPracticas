from PIL import Image
import os
import re

# Ruta de las imagens
dir = "C:/Users/nieto/Downloads/Imagenes/Ejercicio1"

# Extensio de las imagenes
ext = (".png")

imagenes = []

# Recorrer los archivos en el directorio
for archivo in sorted(os.listdir(dir)):
    if archivo.lower().endswith(ext):
        # Ruta completa del archivo de imagen
        ruta_imagen = os.path.join(dir, archivo)
        # Abrir la imagen y agregarla a la lista
        img = Image.open(ruta_imagen)
        imagenes.append(img)

# Verificar si hay imágenes cargadas
if imagenes:
    # Guardar el GIF, ajustando la duración y el loop
    imagenes[0].save('C:/Users/nieto/Downloads/Imagenes/Ejercicio1/Ejercicio1.gif', save_all=True, append_images=imagenes[1:], duration=500, loop=0)
    print("GIF creado exitosamente como 'Ejercicio1.gif'")
else:
    print("No se encontraron imágenes en el directorio.")

