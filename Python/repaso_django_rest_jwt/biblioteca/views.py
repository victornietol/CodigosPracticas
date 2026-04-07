from django.shortcuts import render
from rest_framework.viewsets import ModelViewSet
from .serializers import LibroSerializer, AutorSerializer, EditorialSerializer
from .auth_roles import AllowAllRoles, IsAdmin, IsVendedorOrCliente

class LibroViewSet(ModelViewSet):
    queryset = LibroSerializer.Meta.model.objects.all()
    serializer_class = LibroSerializer

class AutorViewSet(ModelViewSet):
    queryset = AutorSerializer.Meta.model.objects.all()
    serializer_class = AutorSerializer

class EditorialViewSet(ModelViewSet):
    queryset = EditorialSerializer.Meta.model.objects.all()
    serializer_class = EditorialSerializer