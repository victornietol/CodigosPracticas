from sqlalchemy.orm import Session
from models.mamifero_model import Mamimefero
from schemas.mamifero_schema import MamiferoCreate

def get_all(db: Session):
    return db.query(Mamimefero).all()

def get_by_id(db: Session, id: int):
    return db.query(Mamimefero).filter(Mamimefero.id == id).first()

def create(db: Session, mamifero: MamiferoCreate):
    new_object = Mamimefero(**mamifero.model_dump())
    try:
        db.add(new_object)
        db.commit()
        db.refresh(new_object)
    except Exception:
        return None
    else:
        return new_object

def update(db: Session, id: int, data: MamiferoCreate):
    object = db.query(Mamimefero).filter(Mamimefero.id == id).first()
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
    object = db.query(Mamimefero).filter(Mamimefero.id == id).first()
    if not object:
        return None
    try:
        db.delete(object)
        db.commit()
    except Exception:
        return None
    else:
        return object