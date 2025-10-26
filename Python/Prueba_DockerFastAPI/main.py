from fastapi import FastAPI
from routes import mamifero_routes

app = FastAPI(title="Prueba FastAPI")

app.include_router(mamifero_routes.router)