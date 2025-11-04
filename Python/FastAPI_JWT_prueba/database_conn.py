from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# Se indica el nombre del contenedor de la BD en lugar de la ip para que se pueda hacer 
# la conexion a traves de la red creada en docker
#
# El contenedor de la BD es mysql_docker_1:3306   , en este caso se debe indicar el 
# puerto del contenedor docker y no el puerto del host
DATABASE_URL = "mysql+pymysql://root:1234@127.0.0.1:3307/animals"

engine = create_engine(DATABASE_URL, echo=True)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base() # Clase para modelos

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()