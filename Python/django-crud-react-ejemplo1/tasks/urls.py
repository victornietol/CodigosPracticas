from django.urls import path, include
from rest_framework import routers
from tasks import views

router = routers.DefaultRouter()
router.register(r"tasks", views.TaskView, "tasks") # Registra automaticamente con que va a trabajar mi ruta (que hara al visitar con el endpoint final "tasks")

urlpatterns = [
    path("api/v1/", include(router.urls)) # Genera automaticamente mis rutas (GET, POST, PUT, DELETE)
]