import db.db_users as db
from models.User import UserModel
from serializers.User import UserSerializer
from argon2 import PasswordHasher
from argon2.exceptions import VerifyMismatchError

def list_usernames():
    '''Obtener lista de usernames'''
    _users = db.Database.list_usernames()
    users = [user[0] for user in _users]
    return users


def get_users():
    '''Obtener usuarios'''
    users = db.Database.get_users()
    usersSerialized = None
    if users is not None:
        usersSerialized = []
        for user in users:
            userSerialized = UserSerializer(user)
            usersSerialized.append(userSerialized)
    return usersSerialized


def create_user(username, password):
    '''Crear usuario'''
    ph = PasswordHasher() # usando argon2 con settings default
    pass_hashed = ph.hash(password)
    userModel = UserModel(username, pass_hashed)
    code_response = db.Database.save_user(userModel)
    return code_response


def login(username, password):
    '''
    Iniciar sesion de user
    * Return -> Codigo de estado
    '''
    code_response = 400
    user = db.Database.get_user_by_username(username)
    if user is None:
        # Username no existe
        code_response = 401
    else:
        # Verificar hash
        try:
            PasswordHasher().verify(user.password, password)
            code_response = 200
        except VerifyMismatchError:
            code_response = 401
    
    return code_response