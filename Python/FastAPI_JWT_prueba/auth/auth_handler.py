import time
import jwt
from typing import Dict

SECRET_KEY = "clave_secreta_para_firmar" # Debe cambiarse por una clave segura
ALGORITHM = "HS256"

def sign_jwt(user_id: int) -> Dict[str, str]:
    payload = {
        "user_id": str(user_id),
        "expires": time.time() + 300 # Segundos (expiracion en 5 minutos)
    }
    token = jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)
    return {"token": token}


def decode_jwt(token: str) -> dict:
    try:
        decoded = jwt.decode(token, SECRET_KEY, algorithms=ALGORITHM)
        if decoded["expires"] >= time.time():
            return decoded # Valido
        else:
            return None
    except:
        return None