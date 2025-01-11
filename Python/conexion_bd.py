import mysql.connector
from mysql.connector import pooling
from logger_base import log
import sys

class ConexionBD:
    _database = ""
    _user = ""
    _password = ""
    _port = ""
    _host = ""
    _conexion = None
    _cursor = None

    def __init__(self, datos_conexion:dict):
        ConexionBD._host = datos_conexion["host"]
        ConexionBD._user = datos_conexion["user"]
        ConexionBD._password = datos_conexion["password"]
        ConexionBD._database = datos_conexion["database"]
        ConexionBD._port = datos_conexion["port"]

    @classmethod
    def obtener_conexion(cls):
        try:
            cls._conexion = mysql.connector.connect(
                host = cls._host,
                user = cls._user,
                password = cls._password,
                database = cls._database,
                port = cls._port
            )
            cls._conexion.autocommit = False
        except mysql.connector.Error as e:
            log.error(f"No se genero conexion. Ocurrio el error MySQL '{e}' ")
            # sys.exit() # Terminar ejecucion del programa
        except Exception as e:
            log.error(f"No se genero conexion. Ocurrio el error '{e}'")
            # sys.exit() # Terminar ejecucion del programa
        else:
            log.warning(f"Se establecio conexion. {cls._conexion} -> host:'{cls._host}', user:'{cls._user}', password:'{cls._password}', db:'{cls._database}', port:'{cls._port}'")
            return cls._conexion

    @classmethod
    def obtener_cursor(cls):
        if(cls._conexion == None):
            log.error("No se creo una conexion")
            raise ValueError("No se ha creado conexion con la BD.")
        else:
            try:
                cls._cursor = cls._conexion.cursor()
            except Exception as e:
                log.error(f"Ocurrio un error '{e}'")
            else:
                log.warning(f"Se creo el cursor '{cls._cursor}' para la conexion '{cls._conexion}'")
                return cls._cursor

    @classmethod
    def cerrar_cursor_conexion(cls):
        try:
            log.warning(f"Se cerro la conexion: {cls._conexion}")
            cls._cursor.close()
            cls._conexion.close()
            cls._cursor = None
            cls._conexion = None
        except Exception as e:
            log.error(f"Ocurrio el error '{e}'")

    # Otro metodo
    def _ver_registros(datos_conexion:dict, table: str) -> list:
        try:
            if(not table.isidentifier()):
                raise ValueError("Nombre de la tabla no valido.")

            conexion = mysql.connector.connect( # Tambien se puede indicar "**datos_conexion" para no escribir todo el diccionario
                host = datos_conexion["host"],
                user = datos_conexion["user"],
                password = datos_conexion["password"],
                database = datos_conexion["database"],
                port = datos_conexion["port"]
            )
            cursor = conexion.cursor()
            sentencia = f"select * from {table}"
            cursor.execute(sentencia)
            registros = cursor.fetchall()

            return registros
        
        except mysql.connector.Error as e:
            print(f"Ocurrio el error: {e}")

        except Exception as e:
            print("Ocurrio el error inesperado: {e}")

        finally:
            cursor.close()
            conexion.close()

    # Otro metodo
    def _insertar_registro(datos_conexion:dict, table: str, campos: tuple):
        try:
            conexion = mysql.connector.connect(
                host = datos_conexion["host"],
                user = datos_conexion["user"],
                password = datos_conexion["password"],
                database = datos_conexion["database"]
            )
            conexion.autocommit = False
            cursor = conexion.cursor()
            sentencia = "insert into "+table+" (nombre, edad) values (%s,%s)"
            cursor.execute(sentencia, campos)
        
        except mysql.connector.Error as e:
            conexion.rollback()
            print(f"Ocurrio el error: {e}")

        except Exception as e:
            conexion.rollback()
            print(f"Ocurrio el error inesperado: {e}")
        
        else:
            print("Insercion exitosa.")
            conexion.commit()

        finally:
            cursor.close()
            conexion.close()


# Obtener una conexion a la BD a partir de un pool
class ConexionBD_Pool:
    _config_con = dict
    _min_con = int
    _max_con = int
    _pool = None

    def __init__(self, datos_conexion:dict, min_con=1, max_con=5):
        ConexionBD_Pool._config_con = datos_conexion
        ConexionBD_Pool._min_con = min_con
        ConexionBD_Pool._max_con = max_con

    @classmethod
    def obtener_pool(cls):
        if(cls._pool is None):
            try:
                cls._pool = pooling.MySQLConnectionPool(
                    pool_name="pool_pruebas",
                    pool_size=cls._max_con,
                    **cls._config_con
                )
            except Exception as e:
                log.error(f"Ocurrio un error al obtener el pool '{e}'")
                sys.exit()
            else:
                log.warning(f"Se genero el pool de conexiones: {cls._pool}")
                return cls._pool
        else:
            return cls._pool

    @classmethod
    def obtener_conexion(cls):
        conexion = cls.obtener_pool().get_connection()
        log.warning(f"Conexion obtenida del pool: {conexion}") 
        return conexion

    # Regresar la conexion al pool de conexiones
    @classmethod
    def liberar_conexion(cls, conexion):
        log.warning(f"Se regreso la conexion al pool: {conexion}")
        conexion.close()


# Obtener cursor de una conexion valida del pool de conexiones (Ya esta generado el pool)
class CursorDelPool:
    def __init__(self):
        self.__conexion = None
        self.__cursor = None

    # Se ejecuta dentro del metodo with
    def __enter__(self):
        log.warning("Inicio del metodo with __enter__")
        self.__conexion = ConexionBD_Pool.obtener_conexion() # Recupera una la conexion ya establecida
        self.__cursor = self.__conexion.cursor()
        return self.__cursor
    
    def __exit__(self, tipo_excepcion, valor_excepcion, detalle_excepcion):
        log.warning("Se ejecuta metodo __exit__")
        if (valor_excepcion):
            self.__conexion.rollback()
            log.error(f"Ocurrio la excepcion, se hace rollback: '{valor_excepcion}' '{tipo_excepcion}' '{detalle_excepcion}'")
        else:
            self.__conexion.commit()
            log.warning("Commit de la transaccion")
        self.__cursor.close()
        ConexionBD_Pool.liberar_conexion(self.__conexion)


class Persona:
    contador_personas = 0 

    def __init__(self, id=None, nombre="", edad=0) -> None:
        if(id is None):        
            Persona.contador_personas += 1 
            self.__id_persona = Persona.contador_personas
        else:
            self.__id_persona = id
        self.__nombre = nombre
        self.__edad = edad

    @property
    def nombre(self) -> str:
        return self.__nombre
    
    @property
    def edad(self) -> int:
        return self.__edad

    @property
    def id_persona(self) -> int:
        return self.__id_persona
    
    @nombre.setter
    def nombre(self, nombre: str) -> None:
        if(isinstance(nombre, str)):
            self.__nombre = nombre
        else:
            raise ValueError("Nombre debe ser un string")

    @edad.setter
    def edad(self, edad: str) -> None:
        if(isinstance(edad, int)):
            self.__edad = edad
        else:
            raise ValueError("Edad debe ser un numero entero")

    def __str__(self) -> str:
        return f"Id: {self.__id_persona}, Nombre: {self.__nombre}, Edad: {self.__edad}"



class PersonaDAO:
    '''
        DAO = Data Access Object
        CRUD = Create-Read-Update-Delete
    '''
    _SELECT = "select * from personas"
    _INSERT = "insert into personas (nombre, edad) values (%s,%s)"
    _UPDATE = "update personas set"
    _DELETE = "delete from personas where id = %s"

    @classmethod
    def seleccionar(cls, conexion, cursor, id_persona=None) -> list:
        try:
            if(id_persona==None):
                cursor.execute(cls._SELECT)
            elif(id_persona>0):
                cursor.execute(cls._SELECT+" where id = "+str(id_persona)) if (isinstance(id_persona, int)) else log.error("'id_persona' no puede ser del tipo float")
            elif(id_persona<0):
                raise ValueError("'id_persona' no puede ser del tipo float")
            registros = cursor.fetchall() # Si se ejecuta el cursor
        except mysql.connector.Error as e:
            log.error(f"Ocurrio el error '{e}'")
        except TypeError as e:
            log.error("Valor de 'id_persona' no valdo. Debe asigarse un numero entero mayor a cero.")
        except Exception as e:
            log.error(f"Ocurrio el error '{e}'")
        else:
            log.warning(f"Se obtuvieron {cursor.rowcount} registros: {registros} | Conexion [user={conexion.user}, database={conexion.database}, host={conexion.server_host}]")
            return registros

    @classmethod
    def insertar(cls, conexion, cursor, inserciones:list):
        '''
            'inserciones' debe ser una lista de tuplas, las tuplas contienen los campos de los registros a insertar con el formato (nombre,edad)
        '''
        try:
            if(len(inserciones)==1):
                cursor.execute(cls._INSERT, inserciones[0])
            elif(len(inserciones)>1):
                cursor.executemany(cls._INSERT, inserciones)
            elif(len(inserciones)==0):
                raise Exception("No se asignaron valores para asignar")
        except mysql.connector.Error as e:
            log.error(f"Ocurrio el error '{e}'")
        except Exception as e:
            log.error(f"Ocurrio el error '{e}'")
        else:
            log.warning(f"Insercion exitosa. Registros insertados: {cursor.rowcount}= {inserciones} | Conexion [user={conexion.user}, database={conexion.database}, host={conexion.server_host}]")
            conexion.commit()

    @classmethod
    def actualizar(cls, conexion, cursor, id_persona:int, nombre=None, edad=None):
        try:
            if(nombre!=None and edad!=None and id_persona>0):
                sentencia = cls._UPDATE+" nombre = %s, edad = %s where id = %s"
                valores = (nombre, edad, id_persona)
                cursor.execute(sentencia, valores)
            elif(nombre!=None and edad==None and id_persona>0):
                sentencia = cls._UPDATE+" nombre = %s where id = %s"
                valores = (nombre, id_persona)
                cursor.execute(sentencia, valores)
            elif(nombre==None and edad!=None and id_persona>0):
                sentencia = cls._UPDATE+" edad = %s where id = %s"
                valores = (edad, id_persona)
                cursor.execute(sentencia, valores)
            else:
                raise Exception("Valores de los argumentos invalidos.")
        except mysql.connector.Error as e:
            log.error(f"Ocurrio el error '{e}'")
        except Exception as e:
            log.error(f"Ocurrio el error '{e}'")
        else:
            if(cursor.rowcount>0):
                log.warning(f"Actualizacion exitosa. Registros actualizados: {cursor.rowcount}. Valores actualizados: 'id={id_persona}, nombre={nombre}, edad={edad}' | Conexion [user={conexion.user}, database={conexion.database}, host={conexion.server_host}]")
            elif(cursor.rowcount==0):
                log.warning(f"No se actualizaron registros porque se intridujeron los mismos valores existentes. Valores: 'id={id_persona}, nombre={nombre}, edad={edad}' | Conexion [user={conexion.user}, database={conexion.database}, host={conexion.server_host}]")
            conexion.commit()

    @classmethod
    def eliminar(cls, conexion, cursor, id_persona:int):
        try:
            if(id_persona>0 and isinstance(id_persona, int)):
                # Obtener el registro a eliminar para mostrarlo en el log
                registro_eliminado = cls.seleccionar(conexion, cursor, id_persona)
                # Eliminar registro
                valores = (id_persona,)
                cursor.execute(cls._DELETE, valores)
            else:
                raise Exception("Valor de 'id_personas' no valido.")
        except mysql.connector.Error as e:
            log.error(f"Ocurrio el error '{e}'")
        except Exception as e:
            log.error(f"Ocurrio el error '{e}'")
        else:
            log.warning(f"Eliminacion exitosa. Registros eliminados: {cursor.rowcount}. Registro eliminado: '{registro_eliminado}' | Conexion [user={conexion.user}, database={conexion.database}, host={conexion.server_host}]")
            conexion.commit()



class PersonaDAO_Pool:
    '''
        DAO = Data Access Object
        CRUD = Create-Read-Update-Delete
    '''
    _SELECT = "select * from personas"
    _INSERT = "insert into personas (nombre, edad) values (%s,%s)"
    _UPDATE = "update personas set"
    _DELETE = "delete from personas where id = %s"

    @classmethod
    def seleccionar(cls, id_persona=None) -> list:
        with CursorDelPool() as cursor:
            if(id_persona==None):
                cursor.execute(cls._SELECT)
            elif(id_persona>0):
                cursor.execute(cls._SELECT+" where id = "+str(id_persona)) if (isinstance(id_persona, int)) else log.error("'id_persona' no puede ser del tipo float")
            elif(id_persona<0):
                raise ValueError("'id_persona' no puede ser del tipo float")
            registros = cursor.fetchall() # Si se ejecuta el cursor
            personas =  [Persona(id=persona[0],nombre=persona[1],edad=persona[2]) for persona in registros]
            return personas
        

    @classmethod
    def insertar(cls, inserciones:list):
        '''
            'inserciones' debe ser una lista de tuplas, las tuplas contienen los campos de los registros a insertar con el formato (nombre,edad)
        '''
        with CursorDelPool() as cursor:
            if(len(inserciones)==1):
                cursor.execute(cls._INSERT, inserciones[0])
            elif(len(inserciones)>1):
                cursor.executemany(cls._INSERT, inserciones)
            elif(len(inserciones)==0):
                raise Exception("No se asignaron valores para insertar")
            log.warning(f"Insercion exitosa. Registros insertados: {cursor.rowcount}= {inserciones}")
            return cursor.rowcount


    @classmethod
    def actualizar(cls, id_persona:int, nombre=None, edad=None):
        with CursorDelPool() as cursor:
            if(nombre!=None and edad!=None and id_persona>0):
                sentencia = cls._UPDATE+" nombre = %s, edad = %s where id = %s"
                valores = (nombre, edad, id_persona)
                cursor.execute(sentencia, valores)
            elif(nombre!=None and edad==None and id_persona>0):
                sentencia = cls._UPDATE+" nombre = %s where id = %s"
                valores = (nombre, id_persona)
                cursor.execute(sentencia, valores)
            elif(nombre==None and edad!=None and id_persona>0):
                sentencia = cls._UPDATE+" edad = %s where id = %s"
                valores = (edad, id_persona)
                cursor.execute(sentencia, valores)
            else:
                raise Exception("Valores de los argumentos invalidos.")
            if(cursor.rowcount>0):
                log.warning(f"Actualizacion exitosa. Registros actualizados: {cursor.rowcount}. Valores actualizados: 'id={id_persona}, nombre={nombre}, edad={edad}'")
            elif(cursor.rowcount==0):
                log.warning(f"No se actualizaron registros porque se intridujeron los mismos valores existentes. Valores: 'id={id_persona}, nombre={nombre}, edad={edad}'")
            return cursor.rowcount

    @classmethod
    def eliminar(cls, id_persona:int):
        with CursorDelPool() as cursor:
            if(id_persona>0 and isinstance(id_persona, int)):
                # Obtener el registro a eliminar para mostrarlo en el log
                registro_eliminado = cls.seleccionar(id_persona)
                # Eliminar registro
                valores = (id_persona,)
                cursor.execute(cls._DELETE, valores)
            else:
                raise Exception("Valor de 'id_personas' no valido.")
            log.warning(f"Eliminacion exitosa. Registros eliminados: {cursor.rowcount}. Registro eliminado: '{registro_eliminado}'")
            return cursor.rowcount



if __name__ == "__main__":
    datos_conexion = {
        "host":"localhost",
        "user":"root",
        "password":"virgo971000",
        "database":"pruebas",
        "port":3306
    }
    tabla = "personas"
    datos_insertar = ("Fernando",18)

    #insertar_registro(datos_conexion,tabla,datos_insertar)
    #registros = ConexionBD._ver_registros(datos_conexion, tabla)
    #print(registros)


    '''
    # Utilizando clase ConexionDB

    print("Generando conexion y cursor".center(50,"-"))
    ConexionBD(datos_conexion) # Conexion y cursor
    conexion = ConexionBD.obtener_conexion()
    cursor = ConexionBD.obtener_cursor()

    print("Select".center(50,"-"))
    registros = PersonaDAO.seleccionar(conexion=conexion, cursor=cursor) # Select
    print(registros)
    
    print("Insert".center(50,"-"))
    persona1 = Persona(nombre="Manuel",edad=35) # Insert
    inserciones = [(persona1.nombre, persona1.edad)]
    PersonaDAO.insertar(conexion=conexion, cursor=cursor, inserciones=inserciones)
    registros = PersonaDAO.seleccionar(conexion, cursor)
    print(registros)

    print("Update".center(50,"-"))
    PersonaDAO.actualizar(conexion=conexion, cursor=cursor, id_persona=8, nombre="Samuel", edad=19) # Update
    registros = PersonaDAO.seleccionar(conexion, cursor)
    print(registros)

    print("Delete".center(50,"-"))
    PersonaDAO.eliminar(conexion, cursor, 11)
    registros = PersonaDAO.seleccionar(conexion, cursor)
    print(registros)
    
    ConexionBD.cerrar_cursor_conexion()
    '''


    
    # Utilizando Pool de conexiones, (Aqui los registros se devuelven de la base de datos como objetos Persona)

    ConexionBD_Pool(datos_conexion,1,5) # Asignando valores de la conexion
    print("SELECT".center(50,"-"))
    personas = PersonaDAO_Pool().seleccionar()
    for persona in personas:
        print(persona)

    print("INSERT".center(50,"-"))
    inserciones = [("Daniel",24)]
    PersonaDAO_Pool().insertar(inserciones)

    print("UPDATE".center(50,"-"))
    PersonaDAO_Pool.actualizar(id_persona=15,edad=25)

    print("ELIMINAR".center(50,"-"))
    PersonaDAO_Pool.eliminar(5)


    '''
    conexion1 = ConexionBD_Pool.obtener_conexion()
    ConexionBD_Pool.liberar_conexion(conexion1)
    conexion2 = ConexionBD_Pool.obtener_conexion()
    conexion3 = ConexionBD_Pool.obtener_conexion()
    conexion4 = ConexionBD_Pool.obtener_conexion()
    conexion5 = ConexionBD_Pool.obtener_conexion()
    conexion6 = ConexionBD_Pool.obtener_conexion()
    ConexionBD_Pool.liberar_conexion(conexion6)

    
    # Uso de la clase CursorDelPool
    with CursorDelPool() as cursor:
        print("Dentro del bloque with")
        cursor.execute("select * from personas")
        print(cursor.fetchall())
    '''