from django.shortcuts import render
from rest_framework import viewsets
from .serializers import PaisSerializer

class PaisViewSet(viewsets.ModelViewSet):
    queryset = PaisSerializer.Meta.model.objects.all()
    serializer_class = PaisSerializer