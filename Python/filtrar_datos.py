import pandas as pd
from unidecode import unidecode

def filtrar():
    print("Inicio...")
    # Cargar el archivo csv
    archivo = "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/IDM_NM_ago24-utf8.csv"
    df = pd.read_csv(archivo, quotechar='"', skipinitialspace=True)

    print("Procesando...")
    # Filtrar registros
    df_filtrado = df.loc[
        (df['Año'] >= 2015) & (df['Año'] <= 2023) & (df['Clave_Ent'].isin([9,13]))
    ].copy()

    # Columnas de los meses para obtener los valores en int
    columnas_meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 
                    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']

    df_filtrado[columnas_meses] = df_filtrado[columnas_meses].apply(pd.to_numeric, downcast='integer', errors='coerce')

    # Guardar los datos filtrados
    df_filtrado.to_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/delitos_cdmx_hidalgo.csv', index=False, quotechar='"')
    print("Terminado.")

def quitar_acentos_csv(ruta):
    ruta_nuevo_arch = "C:/Users/nieto/Downloads/csv_sin_acentos.csv"
    try:
        print("Leyendo archivo...")
        # Cargar el archivo csv
        df = pd.read_csv(ruta)

        # Eliminar acentos de las columnas str
        print("Quitando acentos...")
        df = df.applymap(lambda x: unidecode(x) if isinstance(x, str) else x) # se revisa cada campo, si es str se quitan acentos, de lo contrario se devuelve el mismo campo

        # Guardar el archivo
        df.to_csv(ruta_nuevo_arch, index=False)
        print(f"Finalizado.\nEl archivo se guardo en {ruta_nuevo_arch}")

    except Exception as e:
        print(f"Ocurrio el error: {e}")

if __name__ == "__main__":
    quitar_acentos_csv("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Poblacion_Municipal.csv")