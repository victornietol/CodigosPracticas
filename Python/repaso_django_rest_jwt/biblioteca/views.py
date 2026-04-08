from django.shortcuts import render
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication

from .serializers import LibroSerializer, AutorSerializer, EditorialSerializer
from .auth_roles_permissions import AllowAllRoles, IsAdmin, IsVendedorOrCliente


class LibroViewSet(ModelViewSet):
    queryset = LibroSerializer.Meta.model.objects.all()
    serializer_class = LibroSerializer
    authentication_classes = [JWTAuthentication] # Necesario para verificar autenticacion con token valido (valida token)
    permission_classes = [IsAuthenticated, AllowAllRoles] ## verifica que el usuario se encuentre autenticado y y verica Roles permitidos

class AutorViewSet(ModelViewSet):
    queryset = AutorSerializer.Meta.model.objects.all()
    serializer_class = AutorSerializer
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated, IsAdmin] ## Solo rol admin

class EditorialViewSet(ModelViewSet):
    queryset = EditorialSerializer.Meta.model.objects.all()
    serializer_class = EditorialSerializer
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated, IsVendedorOrCliente] ## Vendedor o cliente