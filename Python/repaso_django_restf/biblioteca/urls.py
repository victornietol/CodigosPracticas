from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import LibroViewSet, AutorViewSet, EditorialViewSet

router = DefaultRouter()
router.register(r'libros', LibroViewSet, basename='libros')
router.register(r'autores', AutorViewSet, basename='autores')
router.register(r'editorial', EditorialViewSet, basename='editorial')

urlpatterns = [
    path('v1/', include(router.urls))
]