import threading, time

def tarea(nombre: str, delay: int):
    print(f"Inicio tarea {nombre}")
    time.sleep(delay)
    print(f"Termino tarea {nombre}")

hilo1 = threading.Thread(target=tarea, args=("Tarea 1",5))
hilo2 = threading.Thread(target=tarea, args=("Tarea 2", 2))
hilo3 = threading.Thread(target=tarea, args=("Tarea 3", 3.5))
hilo4 = threading.Thread(target=tarea, args=("Tarea 4", 1))

hilo1.start()
hilo2.start()
hilo3.start()
hilo4.start()

hilo1.join()
hilo2.join()
hilo3.join()
hilo4.join()