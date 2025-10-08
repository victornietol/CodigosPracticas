from django.urls import path, include
from rest_framework import routers
from .views import PaisViewSet, OnuViewSet

router = routers.DefaultRouter()

router.register(r'paises', PaisViewSet)
router.register(r'onu', OnuViewSet)

urlpatterns = [
    path('v1/', include(router.urls))
]