from fastapi import Request, HTTPException
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from auth.auth_handler import decode_jwt

class JWTBearer(HTTPBearer):
    def __init__(self, auto_error: bool = True):
        super(JWTBearer, self).__init__(auto_error=auto_error)

    async def __call__(self, request: Request):
        credentials: HTTPAuthorizationCredentials = await super(JWTBearer, self).__call__(request)
        if credentials:
            if not credentials.scheme == "Bearer":
                print("Invalid authentication scheme. script=auth/auth_bearer.py") # Linea de prueba
                raise HTTPException(status_code=403, detail="Sin autorizacion")
            if not self.verify_jwt(credentials.credentials):
                print("Invalid or expired token. script=auth/auth_bearer.py") # Linea de prueba
                raise HTTPException(status_code=403, detail="Sin autorizacion")
            return credentials.credentials
        else:
            print("Invalid authorization code. script=auth/auth_bearer.py") # Linea de prueba
            raise HTTPException(status_code=403, detail="Sin autorizacion")
        
    def verify_jwt(self, token: str) -> bool:
        payload = decode_jwt(token)
        return payload is not None