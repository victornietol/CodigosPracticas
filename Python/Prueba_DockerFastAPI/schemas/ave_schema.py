from pydantic import BaseModel

class AveBase(BaseModel):
    nombre: str

class AveCreate(AveBase):
    pass

class AveResponse(AveBase):
    id: int
    class Config:
        from_attributes = True # Permite devolver objetos SQLAlchemy como respuesta