from rest_framework import serializers
from .models import Centrales, Compania

class CentralesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Centrales
        fields = "__all__"

class CompaniaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Compania
        fields = "__all__"