import mysql.connector
import db.db_settings as db_set
from models.User import UserModel

class Database:
    @staticmethod
    def __open_connection():
        '''Abre conexion con db'''

        conn = mysql.connector.connect(
            host = db_set.HOST,
            user = db_set.USER,
            password = db_set.PASSWORD,
            database = db_set.DATABASE,
            port = db_set.PORT
        )
        return conn


    @staticmethod
    def __close_connection(connection):
        '''Cierra conexion con db'''

        connection.close()


    @staticmethod
    def list_usernames():
        '''
        Lista todos los usuarios de la db (solo los nombres)
        * Return -> List[str]
        '''

        table = "user"
        column = "username"
        query = f"SELECT {column} FROM {table}"
        res = []

        try:
            conn = Database.__open_connection()
            cursor = conn.cursor()
            cursor.execute(query)

        except Exception as e:
            print(f"Error en db_users.py: {e}")

        else: # Correcto
            res = cursor.fetchall()

        finally:
            cursor.close()
            Database.__close_connection(conn)

        return res
    

    @staticmethod
    def get_users() -> list[UserModel]:
        '''
        Obtener lista de usuarios.
        * Return -> List[UserModel]
        '''
        query = "SELECT * FROM user"
        usersModels = None
        try:
            conn = Database.__open_connection()
            cursor = conn.cursor()
            cursor.execute(query)
        except Exception as e:
            print(f"Error: {e}")
        else:
            users = cursor.fetchall()
            usersModels = []
            for user in users:
                userModel = UserModel(username = user[1], password = user[2])
                userModel.id = user[0]
                usersModels.append(userModel)
        finally:
            cursor.close()
            Database.__close_connection(conn)

        return usersModels
    

    @staticmethod
    def get_user_by_username(username) -> UserModel:
        '''
        Obtener user.
        * Return -> UserModel
        '''
        query = "SELECT * from user where username=%s"
        params = (username,)
        userModel = None
        try:
            conn = Database.__open_connection()
            cursor = conn.cursor(prepared=True)
            cursor.execute(query, params)
        except Exception as e:
            print(f"Error: {e}")
        else:
            user = cursor.fetchone()
            if user is not None:
                userModel = UserModel(username=user[1], password=user[2])
                userModel.id = user[0]
        finally:
            cursor.close()
            Database.__close_connection(conn)
        
        return userModel


    @staticmethod
    def save_user(user: UserModel):
        '''Guardar usuario nuevo'''
        query = "INSERT INTO user (username, password) values (%s, %s)"
        params = (user.username, user.password)
        code_response = 400
        try:
            conn = Database.__open_connection()
            cursor = conn.cursor(prepared=True)
            cursor.execute(query, params)
        except Exception as e:
            print(f"Error: {e}")
            code_response = 409 # El usuario ya existe
        else:
            code_response = 201 # Usuario creado
            conn.commit()
        finally:
            cursor.close()
            Database.__close_connection(conn)
        
        return code_response