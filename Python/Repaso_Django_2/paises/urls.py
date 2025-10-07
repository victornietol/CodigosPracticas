from django.urls import path, include
from rest_framework import routers
from .views import PaisViewSet

router = routers.DefaultRouter()

router.register(r'paises', PaisViewSet)

urlpatterns = [
    path('', include(router.urls))
]