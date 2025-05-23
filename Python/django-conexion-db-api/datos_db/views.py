from django.shortcuts import render
from rest_framework import viewsets
from .serializer import ProductorSerializer, TransportistaSerializer, EntidadSerializer
from .models import Productor, Transportista, Entidades

# Create your views here.
class ProductorView(viewsets.ModelViewSet):
    serializer_class = ProductorSerializer
    queryset = Productor.objects.all()

class TransportistaView(viewsets.ReadOnlyModelViewSet):
    serializer_class = TransportistaSerializer
    queryset = Transportista.objects.all()

class EntidadView(viewsets.ReadOnlyModelViewSet):
    serializer_class = EntidadSerializer
    queryset = Entidades.objects.all()