from django.shortcuts import render
from rest_framework import viewsets
from .serializers import PaisSerializer, OnuSerializer

class PaisViewSet(viewsets.ModelViewSet):
    queryset = PaisSerializer.Meta.model.objects.all()
    serializer_class = PaisSerializer

class OnuViewSet(viewsets.ModelViewSet):
    queryset = OnuSerializer.Meta.model.objects.all()
    serializer_class = OnuSerializer