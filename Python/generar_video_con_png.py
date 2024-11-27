from moviepy.editor import ImageSequenceClip

def crear_video():
    # Directorio con imagenes
    ruta = "C:/Victor/Trabajos Fes/9no Semestre/Modelado y Simulacion/Tareas/Tarea4/E6/"

    try:
        # Imagenes
        imagenes = [f"{ruta}e6_salida{i}.png" for i in range(200)]

        # Crear video
        print("Creando video...")
        video = ImageSequenceClip(imagenes, fps=24)
        video.write_videofile(f"{ruta}simulacion6_t4_1.mp4", codec="libx264", bitrate="2000k")
        print("Video generado")

    except Exception as e:
        print(f"Ocurrio el problema: {e}")

# Funcion general para crear el video
def crear_video_especifico(
        ruta: str, # Ruta donde estan guardadas las imagenes y donde se  va a guardar el archivo
        nombre_imagenes: str, # Nombre que tienen las imagenes (debe ser el mismo para todas, solo debe cambiar el numero de la imagen: img0, img1, img2,.. etc)
        n_imagenes: int, # Numero total de imagenes
        nombre_video: str, # Nombre final de video
        formato_img : str # Formato de las imagenes
):
    try:
        # Imagenes
        imagenes = [f"{ruta}{nombre_imagenes}{i}.{formato_img}" for i in range(n_imagenes)]

        # Crear video
        print("Creando video...")
        video = ImageSequenceClip(imagenes, fps=30)
        video.write_videofile(f"{ruta}{nombre_video}.mp4", codec="libx264", bitrate="2000k")
        print("Video generado")

    except Exception as e:
        print(f"Ocurrio el problema: {e}")


if __name__ == "__main__":
    # Utilizar la funcion que se utiliza para crear el video -> crearvideo() ,  crear_video_especifico(ruta, nombre_img, numero_img, nombre_video, formato_img)

    crear_video()
    # crear_video_especifico()