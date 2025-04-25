# Script creado manualmente

from rest_framework import routers
from .api import ProjectViewSet

router = routers.DefaultRouter()

router.register('api/projects', ProjectViewSet, 'projects') # Crea las rutas rutas

urlpatterns = router.urls