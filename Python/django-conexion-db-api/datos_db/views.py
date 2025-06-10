from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets, status
from rest_framework.decorators import action, api_view
from django.shortcuts import get_object_or_404
from .serializer import *
from .models import Productor, Transportista, Entidades, Suministrador

from rest_framework.decorators import authentication_classes, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from rest_framework.authtoken.models import Token

from django.contrib.auth.models import User # Para registrar usuarios y asignar tokens

# Registro y logueo para obtener token
@api_view(["POST"])
def register(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()

        user = User.objects.get(username=serializer.data["username"])
        user.set_password(serializer.data["password"])
        user.save()

        token = Token.objects.create(user=user)
        return Response(
            {"token": token.key, "user": serializer.data},
            status=status.HTTP_201_CREATED
        )
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
@api_view(["POST"])
def login(request):
    user = get_object_or_404(User, username=request.data["username"])
    if not user.check_password(request.data["password"]):
        return Response(
            {"error":"Contraseña incorrecta"},
            status=status.HTTP_400_BAD_REQUEST
        )
    else:
        token, created = Token.objects.get_or_create(user=user) # Regresa una tupla
        serializer = UserSerializer(instance=user)
        return Response(
            {"token": token.key, "user": serializer.data},
            status=status.HTTP_200_OK
        )


# Create your views here.
class ProductorView(viewsets.ModelViewSet):
    serializer_class = ProductorSerializer
    queryset = Productor.objects.all()
    
    # Endpoint personalizado
    @action(
        detail=False, 
        methods=['get'], 
        url_path="by_prod_max/(?P<cantidad>\d+(\.\d{1,2})?)",
        authentication_classes=[TokenAuthentication],  # Si hay un action entonces estos decoradores se pasan como parametros en el action 
        permission_classes=[IsAuthenticated]
    )
    def search_by_prod_max(self, request, cantidad=None):
        try:
            cantidad = float(cantidad)
        except ValueError:
            return Response(
                {"error": "Cantidad invalida"},
                status=status.HTTP_400_BAD_REQUEST
            )
        else:
            productores = Productor.objects.filter(produccion_max__lt=cantidad)
            serializer = self.get_serializer(productores, many=True)
            return Response(
                serializer.data,
                status=status.HTTP_200_OK
            )
    


class TransportistaView(viewsets.ReadOnlyModelViewSet):
    serializer_class = TransportistaSerializer
    queryset = Transportista.objects.all()

class EntidadView(viewsets.ReadOnlyModelViewSet):
    serializer_class = EntidadSerializer
    queryset = Entidades.objects.all()

    # Endpoint personalizado
    @action(detail=False, methods=['get'], url_path="by_name/(?P<nombre>[^/.]+)")
    def search_by_name(self, request, nombre=None):
        element = Entidades.objects.filter(nombre__iexact=nombre)
        if not element.exists():
            return Response(
                {"error": "Elemento no encontrado"},
                status=status.HTTP_404_NOT_FOUND
            )
        serializer = self.get_serializer(element, many=True)
        return Response(
            serializer.data,
            status=status.HTTP_200_OK
        )
    

class SuministradorView(viewsets.ModelViewSet):
    serializer_class = SuministradorSerializer
    queryset = Suministrador.objects.all()

    @action(detail=False, methods=['put'], url_path="update_nombre")
    def suministrador_actualizar(self, request): # Si no se especifica url_path entonces se utiliza el nombre de la funcion como endpoint
        pk = request.data.get("id_suministrador") # Nombre del campo de la pk en la BD
        nombre = request.data.get("nombre") # Campo a actualizar

        if not pk:
            return Response(
                {"Error": "Falta el campo id_suministrador"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        if not nombre:
            return Response(
                {"Error": "Falta el campo a actualizar 'nombre'"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        try:
            suministrador = Suministrador.objects.get(id_suministrador=pk)
        except Suministrador.DoesNotExist:
            return Response(
                {"Error": "Suministrador no encontrado, verifica el el campo id"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        suministrador.nombre = nombre
        suministrador.save() # el nombre en la base de datos se pasara automatimante a mayusculas porque la BD tiene un trigger defino desde sql para ello
        serializer = SuministradorSerializer(instance=suministrador) # Se pasa el objeto del Modelo correspondiente
        return Response(
            serializer.data,
            status=status.HTTP_200_OK
        )