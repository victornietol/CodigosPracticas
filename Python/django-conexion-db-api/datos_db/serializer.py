from rest_framework import serializers
from .models import Productor, Transportista, Entidades # Tablas a mostrar

class ProductorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Productor
        fields = "__all__"

class TransportistaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transportista
        fields = "__all__"

class EntidadSerializer(serializers.ModelSerializer):
    class Meta:
        model = Entidades
        fields = "__all__"