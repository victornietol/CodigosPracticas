from pydantic import BaseModel

class ReptilBase(BaseModel):
    nombre: str

class ReptilCreate(ReptilBase):
    pass

class ReptilResponse(ReptilBase):
    id: int
    class Config:
        orm_mode = True # Permite devolver objetos SQLAlchemy como respuesta