from sqlalchemy import Column, Integer, String
from database_conn import Base

class Mamimefero(Base):
    __tablename__ = "mamifero"

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)