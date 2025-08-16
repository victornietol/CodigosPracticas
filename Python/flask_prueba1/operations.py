import db.db_users as db
from argon2 import PasswordHasher
from argon2.exceptions import VerifyMismatchError

def get_users():
    '''Obtener lista de usuarios'''
    _users = db.Database.get_users()
    users = [user[0] for user in _users]
    return users


def create_user(username, password):
    '''Crear usuario'''
    ph = PasswordHasher() # usando argon2 con settings default
    pass_hashed = ph.hash(password)
    code_response = db.Database.save_user(username, pass_hashed)
    return code_response


def login(username, password):
    '''
    Iniciar sesion de user
    * Return -> Codigo de estado
    '''
    code_response = 400
    password_db = db.Database.get_user_by_username(username)
    if password_db==None:
        # Username no existe
        code_response = 401
    else:
        # Verificar hash
        password_db = password_db[0]
        try:
            PasswordHasher().verify(password_db, password)
            code_response = 200
        except VerifyMismatchError:
            code_response = 401
    
    return code_response