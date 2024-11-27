import csv
import pandas as pd
import re

def sustituir_texto():
    with open('C:/Users/nieto/Downloads/datos_p7.csv', 'r', newline='', encoding='utf-8') as csv_lectura, \
        open('C:/Users/nieto/Downloads/datosP7.csv', 'w', newline='', encoding='utf-8') as csv_salida:

        lector = csv.reader(csv_lectura)
        escribir = csv.writer(csv_salida)

        for fila in lector:
            fila_limpia = [celda.replace(" { t}", "") for celda in fila]

            escribir.writerow(fila_limpia)


def quitar_comillas(texto):
    re.sub(r"'[^']*'", '', texto)

def modificar_entre_comillas():
    df = pd.read_csv('C:/Users/nieto/Downloads/datosP7.csv')
    
    df = df.applymap(lambda x: quitar_comillas(x) if isinstance(x, str) else x)

    df.to_csv('C:/Users/nieto/Downloads/datosP7_1.csv', index=False)

if __name__ == '__main__':
    modificar_entre_comillas()