import db.db_users as db
from argon2 import PasswordHasher

def get_users():
    '''Obtener lista de usuarios'''
    users = db.Database.get_users()
    return users

def create_user(username, password):
    '''Crear usuario'''
    ph = PasswordHasher() # usando argon2 con settings default
    pass_hashed = ph.hash(password)
    code_response = db.Database.save_user(username, pass_hashed)
    return code_response
