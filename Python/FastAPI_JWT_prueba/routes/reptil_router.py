from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database_conn import get_db

from schemas.reptil_schema import ReptilCreate, ReptilResponse
from repositories import reptil_repository

router = APIRouter(prefix="/reptiles", tags=["Reptiles"])

@router.get("/", response_model=list[ReptilResponse])
def get_reptiles(db: Session = Depends(get_db)):
    return reptil_repository.get_all(db)

@router.get("/{id}", response_model=ReptilResponse)
def get_reptil(id: int, db: Session = Depends(get_db)):
    object = reptil_repository.get_by_id(db, id)
    if not object:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Objeto no encontrado.")
    return object

@router.post("/", response_model=ReptilResponse, status_code=status.HTTP_201_CREATED)
def create(data: ReptilCreate, db: Session = Depends(get_db)):
    return reptil_repository.create(db, data)

@router.put("/{id}", response_model=ReptilResponse)
def update(id: int, data: ReptilCreate, db: Session = Depends(get_db)):
    object = reptil_repository.update(db, id, data)
    if not object:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Objeto no encontrado")
    return object

@router.delete("/{id}", status_code=status.HTTP_204_NO_CONTENT)
def delete(id: int, db: Session = Depends(get_db)):
    object = reptil_repository.delete(db, id)
    if not object:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Objeto no encontrado.")
    return {"message": "Objeto eliminado."}