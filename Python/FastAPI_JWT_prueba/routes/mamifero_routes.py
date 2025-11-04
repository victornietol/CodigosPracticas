from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database_conn import get_db

from schemas.mamifero_schema import MamiferoCreate, MamiferoResponse
from repositories import mamifero_repository

router = APIRouter(prefix="/mamiferos", tags=["Mamiferos"])

@router.get("/", response_model=list[MamiferoResponse])
def get_mamiferos(db: Session = Depends(get_db)):
    return mamifero_repository.get_all(db)

@router.get("/{id}", response_model=MamiferoResponse)
def get_mamifero(id: int, db: Session = Depends(get_db)):
    object = mamifero_repository.get_by_id(db, id)
    if not object:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Objeto no encontrado.")
    return object

@router.post("/", response_model=MamiferoResponse, status_code=status.HTTP_201_CREATED)
def create(data: MamiferoCreate, db: Session = Depends(get_db)):
    return mamifero_repository.create(db, data)

@router.put("/{id}", response_model=MamiferoResponse)
def update(id: int, data: MamiferoCreate, db: Session = Depends(get_db)):
    object = mamifero_repository.update(db, id, data)
    if not object:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Objeto no encontrado")
    return object

@router.delete("/{id}", status_code=status.HTTP_204_NO_CONTENT)
def delete(id: int, db: Session = Depends(get_db)):
    object = mamifero_repository.delete(db, id)
    if not object:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Objeto no encontrado.")
    return {"message": "Objeto eliminado."}