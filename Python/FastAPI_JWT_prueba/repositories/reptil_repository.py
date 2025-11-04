from sqlalchemy.orm import Session
from models.reptil_model import Reptil
from schemas.reptil_schema import ReptilCreate

def get_all(db: Session):
    return db.query(Reptil).all()

def get_by_id(db: Session, id: int):
    return db.query(Reptil).filter(Reptil.id == id).first()

def create(db: Session, reptil: ReptilCreate):
    new_object = Reptil(**reptil.model_dump())
    try:
        db.add(new_object)
        db.commit()
        db.refresh(new_object)
    except Exception:
        return None
    else:
        return new_object

def update(db: Session, id: int, data: ReptilCreate):
    object = db.query(Reptil).filter(Reptil.id == id).first()
    if not object:
        return None
    try:
        for key, value in data.model_dump().items():
            setattr(object, key, value)
        db.commit()
        db.refresh(object)
    except Exception:
        return None
    else:
        return object
    
def delete(db: Session, id: int):
    object = db.query(Reptil).filter(Reptil.id == id).first()
    if not object:
        return None
    try:
        db.delete(object)
        db.commit()
    except Exception:
        return None
    else:
        return object