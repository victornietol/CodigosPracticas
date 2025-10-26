from pydantic import BaseModel

class MamiferoBase(BaseModel):
    nombre: str

class MamiferoCreate(MamiferoBase):
    pass

class MamiferoResponse(MamiferoBase):
    id: int
    class Config:
        orm_mode = True # Permite devolver objetos SQLAlchemy como respuesta