from fastapi import FastAPI, Depends, HTTPException, APIRouter
from auth.auth_handler import sign_jwt
from auth.auth_bearer import JWTBearer
from schemas.login_schema import LoginBase

# Obtencion de users solo para este ejemplo
from models.users_example import USERS


router = APIRouter(prefix="/auth", tags=["Auth"])

@router.post("/login")
def login(request: LoginBase):
    # Simulacion de autenticacion solo para este ejemplo, esta logica debe ir en otro lado
    user = next((u for u in USERS if u["username"]==request.username and u["password"]==request.password), None)
    if not user:
        print("Credenciales invalidas, script=routes/auth_routes.py")
        raise HTTPException(status_code=401, detail="Credenciales invalidas")
    return sign_jwt(user["id"]) # Se utiliza el id del user logueado

# Endpoint de prueba
@router.get("/protected", dependencies=[Depends(JWTBearer())])
def protected_route():
    return {"message": "Bienvenido, acceso autorizado"}