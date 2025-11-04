from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database_conn import get_db

from schemas.ave_schema import AveCreate, AveResponse
from repositories import ave_repository

router = APIRouter(prefix="/aves", tags=["Aves"])

@router.get("/", response_model=list[AveResponse])
def get_aves(db: Session = Depends(get_db)):
    return ave_repository.get_all(db)

@router.get("/{id}", response_model=AveResponse)
def get_ave(id: int, db: Session = Depends(get_db)):
    object = ave_repository.get_by_id(db, id)
    if not object:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Objeto no encontrado.")
    return object

@router.post("/", response_model=AveResponse, status_code=status.HTTP_201_CREATED)
def create(data: AveCreate, db: Session = Depends(get_db)):
    return ave_repository.create(db, data)

@router.put("/{id}", response_model=AveResponse)
def update(id: int, data: AveCreate, db: Session = Depends(get_db)):
    object = ave_repository.update(db, id, data)
    if not object:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Objeto no encontrado")
    return object

@router.delete("/{id}", status_code=status.HTTP_204_NO_CONTENT)
def delete(id: int, db: Session = Depends(get_db)):
    object = ave_repository.delete(db, id)
    if not object:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Objeto no encontrado.")
    return {"message": "Objeto eliminado."}