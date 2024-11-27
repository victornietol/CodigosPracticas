import chardet

def verificar_cod(ruta: str):
    print("Verificando...")
    try:
        # Abrir archivo
        with open (ruta, 'rb') as archivo:
            datos = archivo.read()

        # Detectar codificacion
        resultado = chardet.detect(datos)
        codificacion = resultado['encoding']
        confianza = resultado['confidence']

        print(f"Codificacion: {codificacion} (Confianza: {confianza})")
    
    except Exception as e:
        print(f"Ocurrio el problema {e}")


if __name__ == "__main__":
    pass
    verificar_cod("C:/Victor/delitos_cdmx_hidalgo.csv")