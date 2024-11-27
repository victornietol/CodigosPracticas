import tkinter as tk
import cifrado_cesar
from tkinter import ttk, messagebox


class Interfaz():
    def __init__(self):
        # Creado ventana
        self.ventana = tk.Tk()
        self.ventana.geometry("700x550")
        self.ventana.title("Cifrado Cesar")
        self.ventana.resizable(0, 0)

        # Panel para las pestañas
        nb = ttk.Notebook(self.ventana)
        nb.pack(fill='both', expand='yes')

        # Construyendo pestañas y su contenido
        self.pestania1 = self.construir_pestania1(nb)
        self.pestania2 = self.construir_pestania2(nb)

        # Agregando pestanias
        nb.add(self.pestania1, text='Cifrado')
        nb.add(self.pestania2, text='Descifrado')

        self.ventana.mainloop()



    def cifrar_texto(self, texto, llave, ventana_cerrar, caja_texto_cifrado):
        try:
            llave = int(llave)
            if(llave == 0):
                messagebox.showwarning("Error", "Llave con valor de 0")
            else:
                texto_cifrado = cifrado_cesar.cifrar_mensaje(texto, llave)

                # Asignando el texto cifrado a la caja de texto
                caja_texto_cifrado.config(state=tk.NORMAL)
                caja_texto_cifrado.delete("1.0", tk.END)
                caja_texto_cifrado.insert(tk.END, texto_cifrado)
                caja_texto_cifrado.config(state=tk.DISABLED)

                # Ventana a cerrar
                ventana_cerrar.destroy()

        except Exception:
            messagebox.showerror("Error","Llave invalida.")


    
    def descifrar_texto(self, texto, llave, ventana_cerrar, caja_texto_cifrado):
        try:
            llave = int(llave)
            if(llave == 0):
                messagebox.showwarning("Error", "Llave con valor de 0")
            else:
                texto_descifrado = cifrado_cesar.descifrar_mensaje(texto, llave)

                # Asignando el texto cifrado a la caja de texto
                caja_texto_cifrado.config(state=tk.NORMAL)
                caja_texto_cifrado.delete("1.0", tk.END)
                caja_texto_cifrado.insert(tk.END, texto_descifrado)
                caja_texto_cifrado.config(state=tk.DISABLED)

                # Ventana a cerrar
                ventana_cerrar.destroy()

        except Exception:
            messagebox.showerror("Error","Llave invalida.")



    def boton_cifrar_texto(self, caja_texto, caja_texto_cifrado):
        '''
            Unicamente despliega una nueva ventana para introducir la llave
            y ejecuta el proceso para cifrar el texto
        '''
        # Obteniendo contenido de la caja de texto
        texto_plano = caja_texto.get("1.0", tk.END)

        # Crear nueva ventana para ingresar la llave
        sub_ventana = tk.Toplevel(self.ventana)
        sub_ventana.geometry("300x200")
        sub_ventana.title("Llave")

        sub_ventana.grid_columnconfigure(0, weight=1)

        # Texto
        label_texto = tk.Label(sub_ventana, text='Ingresa la llave')
        label_texto.grid(row=0, column=0, sticky='ew', padx=10, pady=10)

        # Entrada de texto
        texto_llave = tk.StringVar()
        self.entry_llave = ttk.Entry(sub_ventana, textvariable=texto_llave)
        self.entry_llave.grid(row=1, column=0, sticky='ew', padx=90, pady=10)

        # Boton
        boton = ttk.Button(
            sub_ventana,
            text = 'Aceptar',
            command = lambda: self.cifrar_texto(
                texto_plano, texto_llave.get(), sub_ventana, caja_texto_cifrado
            ),
            cursor = 'hand2'
        )
        boton.grid(row=2, column=0, sticky='ew', padx=90, pady=10)


    
    def boton_descifrar_texto(self, caja_texto, caja_texto_descifrado):
        '''
            Unicamente despliega una nueva ventana para introducir la llave
            y ejecuta el proceso para descifrar el texto
        '''
        # Obteniendo contenido de la caja de texto
        texto_cifrado = caja_texto.get("1.0", tk.END)

        # Crear nueva ventana para ingresar la llave
        sub_ventana = tk.Toplevel(self.ventana)
        sub_ventana.geometry("300x200")
        sub_ventana.title("Llave")

        sub_ventana.grid_columnconfigure(0, weight=1)

        # Texto
        label_texto = tk.Label(sub_ventana, text='Ingresa la llave')
        label_texto.grid(row=0, column=0, sticky='ew', padx=10, pady=10)

        # Entrada de texto
        texto_llave = tk.StringVar()
        self.entry_llave = ttk.Entry(sub_ventana, textvariable=texto_llave)
        self.entry_llave.grid(row=1, column=0, sticky='ew', padx=90, pady=10)

        # Boton
        boton = ttk.Button(
            sub_ventana,
            text = 'Aceptar',
            command = lambda: self.descifrar_texto(
                texto_cifrado, texto_llave.get(), sub_ventana, caja_texto_descifrado
            ),
            cursor = 'hand2'
        )
        boton.grid(row=2, column=0, sticky='ew', padx=90, pady=10)



    def borrar_cajas_texto(self, caja_texto_plano, caja_texto_cifrado):
        # Caja texto plano
        caja_texto_plano.delete("1.0", tk.END)

        # Caja texto cifrado
        caja_texto_cifrado.config(state=tk.NORMAL)
        caja_texto_cifrado.delete("1.0", tk.END)
        caja_texto_cifrado.config(state=tk.DISABLED)



    def construir_pestania1(self, notebook):
        frame_principal = tk.Frame(notebook, bg='white', height=400)
        frame_principal.pack(fill='both', expand=True)

        subFrame_superior = tk.Frame(frame_principal, bg='white', height=150)
        subFrame_central = tk.Frame(frame_principal, bg='white', height=150)
        subFrame_inferior = tk.Frame(frame_principal, bg='white', height=100)

        subFrame_superior.pack(fill='both', expand=True)
        subFrame_central.pack(fill='both', expand=True)
        subFrame_inferior.pack(fill='both', expand=True)

        # Contenido de los frames
        label_mensaje = tk.Label(subFrame_superior, text='Ingrese el mensaje a cifrar', bg='white')
        label_mensaje.grid(row=0, column=0, sticky="ew")

        # Caja de texto
        caja_texto = tk.Text(subFrame_superior, wrap='word', height=12, relief='solid')
        caja_texto.grid(row=1, column=0, sticky='ew', padx=25, pady=(20,0))

        label_mensaje_des = tk.Label(subFrame_central, text='Mensaje cifrado', bg='white')
        label_mensaje_des.grid(row=0, column=0, sticky="ew")

        caja_texto_cifrado = tk.Text(subFrame_central, wrap='word', height=12, relief='solid')
        caja_texto_cifrado.grid(row=1, column=0, sticky='ew', padx=25, pady=(10,10))
        caja_texto_cifrado.config(state=tk.DISABLED)

        # Botones 
        boton_leer = ttk.Button(
            subFrame_inferior,
            text = 'Cifrar texto',
            command = lambda: self.boton_cifrar_texto(caja_texto, caja_texto_cifrado),
            cursor = 'hand2'
        )
        boton_leer.grid(row=0, column=0, padx=20, pady=10, sticky='ew')

        boton_borrar = ttk.Button(
            subFrame_inferior,
            text = 'Borrar texto',
            command = lambda: self.borrar_cajas_texto(caja_texto, caja_texto_cifrado),
            cursor = 'hand2'
        )
        boton_borrar.grid(row=0, column=1, padx=20, pady=10, sticky='ew')

        return frame_principal
    


    def construir_pestania2(self, notebook):
        frame_principal = tk.Frame(notebook, bg='white', height=400)
        frame_principal.pack(fill='both', expand=True)

        subFrame_superior = tk.Frame(frame_principal, bg='white', height=150)
        subFrame_central = tk.Frame(frame_principal, bg='white', height=150)
        subFrame_inferior = tk.Frame(frame_principal, bg='white', height=100)

        subFrame_superior.pack(fill='both', expand=True)
        subFrame_central.pack(fill='both', expand=True)
        subFrame_inferior.pack(fill='both', expand=True)

        # Contenido de los frames
        label_mensaje = tk.Label(subFrame_superior, text='Ingrese el mensaje a descifrar', bg='white')
        label_mensaje.grid(row=0, column=0, sticky="ew")

        # Caja de texto
        caja_texto = tk.Text(subFrame_superior, wrap='word', height=12, relief='solid')
        caja_texto.grid(row=1, column=0, sticky='ew', padx=25, pady=(20,0))

        label_mensaje_des = tk.Label(subFrame_central, text='Mensaje descifrado', bg='white')
        label_mensaje_des.grid(row=0, column=0, sticky="ew")

        caja_texto_cifrado = tk.Text(subFrame_central, wrap='word', height=12, relief='solid')
        caja_texto_cifrado.grid(row=1, column=0, sticky='ew', padx=25, pady=(10,10))
        caja_texto_cifrado.config(state=tk.DISABLED)    

        # Botones 
        boton_leer = ttk.Button(
            subFrame_inferior,
            text = 'Descifrar texto',
            command = lambda: self.boton_descifrar_texto(caja_texto, caja_texto_cifrado),
            cursor = 'hand2'
        )
        boton_leer.grid(row=0, column=0, padx=20, pady=10, sticky='ew')

        boton_borrar = ttk.Button(
            subFrame_inferior,
            text = 'Borrar texto',
            command = lambda: self.borrar_cajas_texto(caja_texto, caja_texto_cifrado),
            cursor = 'hand2'
        )
        boton_borrar.grid(row=0, column=1, padx=20, pady=10, sticky='ew')

        return frame_principal
    



if __name__ == '__main__':
    ventana = Interfaz()