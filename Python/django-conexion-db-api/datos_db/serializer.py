from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Productor, Transportista, Entidades, Suministrador # Tablas a mostrar

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["id", "username", "email", "password"]

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

class SuministradorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Suministrador
        fields = "__all__"