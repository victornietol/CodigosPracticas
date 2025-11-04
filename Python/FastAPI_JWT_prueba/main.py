from fastapi import FastAPI
from routes import mamifero_routes, ave_router, reptil_router

app = FastAPI(title="Prueba FastAPI")

app.include_router(mamifero_routes.router)
app.include_router(ave_router.router)
app.include_router(reptil_router.router)