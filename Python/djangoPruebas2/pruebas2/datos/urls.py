from rest_framework import routers
from .views import *

router = routers.DefaultRouter()

router.register(r"Centrales", CentralesViewSet, basename="centrales")
router.register(r"compania", CompaniaViewSet, basename="compania")

urlpatterns = router.urls