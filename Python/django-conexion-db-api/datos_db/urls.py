from django.urls import path, include, re_path
from rest_framework import routers
from datos_db import views

router = routers.DefaultRouter()
router.register(r"productores", views.ProductorView, "productores")
router.register(r"transportistas", views.TransportistaView, "transportistas")
router.register(r"entidades", views.EntidadView, "entidades")

urlpatterns = [
    path("api/v1/", include(router.urls)),
    re_path("api/v1/register", views.register),
    re_path("api/v1/login", views.login)
]