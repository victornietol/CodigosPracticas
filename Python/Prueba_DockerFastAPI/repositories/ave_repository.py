from sqlalchemy.orm import Session
from models.ave_model import Ave
from schemas.ave_schema import AveCreate

def get_all(db: Session):
    return db.query(Ave).all()

def get_by_id(db: Session, id: int):
    return db.query(Ave).filter(Ave.id == id).first()

def create(db: Session, ave: AveCreate):
    new_object = Ave(**ave.model_dump())
    try:
        db.add(new_object)
        db.commit()
        db.refresh(new_object)
    except Exception:
        return None
    else:
        return new_object

def update(db: Session, id: int, data: AveCreate):
    object = db.query(Ave).filter(Ave.id == id).first()
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
    object = db.query(Ave).filter(Ave.id == id).first()
    if not object:
        return None
    try:
        db.delete(object)
        db.commit()
    except Exception:
        return None
    else:
        return object