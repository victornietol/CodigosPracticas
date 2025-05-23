from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets, status
from rest_framework.decorators import action
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