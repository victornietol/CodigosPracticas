import tkinter as tk
from tkinter import ttk
import hashlib, bcrypt, mysql.connector
from mysql.connector import Error

class Interfaz():
    def __init__(self):
        # Creado ventana
        self.ventana = tk.Tk()
        self.ventana.geometry("600x250")
        self.ventana.title("Verificación Usuario")
        self.ventana.resizable(0, 0)

        # Crear Frames
        self.v_frame_superior = tk.Frame(self.ventana, bg='white', height=150)
        self.v_frame_superior.pack(fill='both', expand=True)

        self.v_frame_central = tk.Frame(self.ventana, bg='white', height=50) # Donde esta el mensaje
        self.v_frame_central.pack(fill='both', expand=True)

        self.v_frame_inferior = tk.Frame(self.ventana, bg='white', height=100)
        self.v_frame_inferior.pack(fill='both', expand=True)


        # Textos
        self.label_usuario = tk.Label(self.v_frame_superior, text='Usuario', bg='white')
        self.label_usuario.grid(row=0, column=0, padx=(100,10), pady=20, sticky="w")  # Coloca el Label de Usuario

        self.label_password = tk.Label(self.v_frame_superior, text='Contraseña', bg='white')
        self.label_password.grid(row=1, column=0, padx=(100,10), pady=20, sticky="w")  # Coloca el Label de Contraseña

        # Campo para el resultado
        self.label_resultado = tk.Label(self.v_frame_central, text='', bg='white', wraplength=500)
        self.label_resultado.grid(row=0, column=0, columnspan=3, pady=10, sticky='ew')  # Centrado horizontalmente

        # Entradas de texto
        self.texto_user = tk.StringVar()
        self.texto_passw = tk.StringVar()

        self.entry_user = ttk.Entry(self.v_frame_superior, textvariable=self.texto_user, width=30)
        self.entry_user.grid(row=0, column=1, sticky="w")

        self.entry_passw = ttk.Entry(self.v_frame_superior, textvariable=self.texto_passw, width=30, show='*')
        self.entry_passw.grid(row=1, column=1, sticky="w")

        # Botones
        self.boton_verificar = ttk.Button(
                self.v_frame_inferior, 
                text='Verificar', 
                command=lambda: self.verificar_user(self.texto_user.get(),self.texto_passw.get()), 
                cursor='hand2'
            )
        self.boton_verificar.grid(row=0, column=0, padx=50, pady=10, sticky='ew')

        self.boton_nuevo_user = ttk.Button(
                self.v_frame_inferior, 
                text='Nuevo Usuario', 
                command=lambda: self.nuevo_user(self.texto_user.get(),self.texto_passw.get()), 
                cursor='hand2'
            )
        self.boton_nuevo_user.grid(row=0, column=1, padx=50, pady=10, sticky='ew')

        self.boton_reiniciar = ttk.Button(
                self.v_frame_inferior, 
                text='Reiniciar', 
                command=lambda: self.reiniciar(), 
                cursor='hand2',
            )
        self.boton_reiniciar.grid(row=0, column=2, padx=50, pady=10, sticky='ew')

        # Configurar la expansión horizontal del frame
        #self.v_frame_superior.grid_columnconfigure(0, weight=0)
        #self.v_frame_superior.grid_columnconfigure(1, weight=0)
        #self.v_frame_inferior.grid_columnconfigure(0, weight=0)
        self.v_frame_central.grid_columnconfigure(0, weight=1)

        self.ventana.mainloop()

    def verificar_user(self, usuario: str, passw: str):
        # Conexion con la BD
        try:
            conexion = mysql.connector.connect(
                host = 'localhost',
                user = 'root',
                password = 'virgo971000',
                database = 'hash_pruebas'
            )
            cursor = conexion.cursor()

            # Ejecutando consulta de verificacion
            cursor.execute("select * from cuentas where usuario = %s", (usuario,))
            cuenta = cursor.fetchone()
            # Cerrar conexion de la BD
            cursor.close()
            conexion.close()
            # Verificando usuario y contraseña
            if(cuenta == None):
                self.label_resultado.config(text='No exite el usuario', fg='red')
            else:   # Verificar la contraseña
                passw_hash_bd = cuenta[2] # Obtener hash de la BD
                coincide = bcrypt.checkpw(passw.encode('utf-8'), passw_hash_bd.encode('utf-8')) # Verificar que coincidan los hash de los passw
                if(coincide):
                    self.label_resultado.config(text='Credenciales correctas', fg='green')
                else:
                    self.texto_passw.set('')
                    self.label_resultado.config(text='Contraseña incorrecta', fg='red')

        except mysql.connector.Error as e:
            # Captura de un error en la conexion
            self.label_resultado.config(text=f'Ocurrió el error: {e.msg}', fg='red')
        except Exception as e:
            # Captura de cualquier otra excepción
            self.label_resultado.config(text=f'Ocurrió un error inesperado: {e}', fg='red')

    def reiniciar(self):
        self.label_resultado.config(text='')
        self.texto_user.set('')
        self.texto_passw.set('')

    def aplicar_hash256(self, passw) -> str:
        # Utilizar SHA256
        sha265 = hashlib.sha256()

        # Aplicar sha256
        sha265.update(passw.encode('utf-8'))

        # Pasar a hexadecimal
        hash256 = sha265.hexdigest()

        return hash256
    
    def aplicar_hash_bcrypt(self, passw) -> str:
        # Generar salt
        salt = bcrypt.gensalt(15)

        # Generar hash
        passw_hash = bcrypt.hashpw(passw.encode('utf-8'), salt)

        return passw_hash.decode()
    
    def nuevo_user(self, usuario: str, passw: str):
        if(usuario.__contains__(" ")):
            self.label_resultado.config(text='El usuario contiene espacios en blanco', fg='red')
        elif(passw.__contains__(" ")):
            self.label_resultado.config(text='La contraseña contiene espacios en blanco', fg='red')
        elif(usuario == ""):
            self.label_resultado.config(text='El usuario no es valido', fg='red')
        else:
            # Conexcion BD
            try:
                conexion = mysql.connector.connect(
                    host = 'localhost',
                    user = 'root',
                    password = 'virgo971000',
                    database = 'hash_pruebas'
                )
                cursor = conexion.cursor()

                # Aplicando hash al password
                passw_hash = self.aplicar_hash_bcrypt(passw)

                # Ingresando nuevo usuario
                cursor.execute("insert into cuentas (usuario, passw) values  (%s,%s)", (usuario,passw_hash))
                conexion.commit()

                cursor.close()
                conexion.close()

                # Mensaje de usuario creado
                self.label_resultado.config(text='Usuario creado correctamente', fg='blue')

            except mysql.connector.IntegrityError as e:
                # Captura de error de clave duplicada
                self.label_resultado.config(text='El usuario ya existe', fg='red')
            except mysql.connector.Error as e:
                # Captura de cualquier otro error de MySQL
                self.label_resultado.config(text=f'Ocurrió el error: {e.msg}', fg='red')
            except Exception as e:
                # Captura de cualquier otra excepción
                self.label_resultado.config(text=f'Ocurrió un error inesperado: {e}', fg='red')
                

def main():
    mi_app = Interfaz()
    return 0

if __name__ == "__main__":
    main()
    '''
    aux='hola'
    sha265 = hashlib.sha256()

    # Aplicar sha256
    sha265.update(aux.encode('utf-8'))
    hash = sha265.hexdigest()
    print(hash)


    salt = bcrypt.gensalt(15)

    # Generar hash
    passw_hash = bcrypt.hashpw(aux.encode('utf-8'), salt)
    deco = passw_hash.decode()

    print(passw_hash.decode())
    print(
        bcrypt.checkpw(aux.encode('utf-8'),deco.encode('utf-8'))
    )
    '''