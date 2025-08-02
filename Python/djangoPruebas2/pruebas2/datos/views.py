from django.shortcuts import render
from rest_framework import viewsets
from pruebas2.datos.serializers import *

# Create your views here.
class CentralesViewSet(viewsets.ModelViewSet):
    serializer_class = CentralesSerializer
    queryset = CentralesSerializer.Meta.model.objects.all() # El serializaer ya incluye la clase, entonces no es necesario hacer un import de models otra vez

class CompaniaViewSet(viewsets.ModelViewSet):
    serializer_class = CompaniaSerializer
    queryset = CompaniaSerializer.Meta.model.objects.all()