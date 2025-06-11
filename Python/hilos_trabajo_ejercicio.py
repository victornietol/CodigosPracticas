import threading, time

class Foo:
    def __init__(self):
        self.first_done = threading.Event()
        self.second_done = threading.Event()

    def first(self, printFirst):
        printFirst()
        self.first_done.set()

    def second(self, printSecond):
        self.first_done.wait()
        printSecond()
        self.second_done.set()

    def third(self, printThird):
        self.second_done.wait()
        printThird()


def printFirst():
    print("1. inicio first")
    print("1. espera ...")
    time.sleep(3)
    print("1. final first")


def printSecond():
    print("2. inicio second")
    print("2. espera ...")
    time.sleep(3)
    print("2. final second")

def printThird():
    print("3. inicio third")
    print("3. espera ...")
    time.sleep(3)
    print("3. final third")


# Pruebas
from threading import Thread

foo = Foo()

t1 = Thread(target=foo.first, args=(printFirst,)) # Indica que funcion se va a ejecutar y sus parametros
t2 = Thread(target=foo.second, args=(printSecond,))
t3 = Thread(target=foo.third, args=(printThird,))

# Ejecutando en cualquier orden
t2.start()
t3.start()
t1.start()

t1.join()
t2.join()
t3.join()