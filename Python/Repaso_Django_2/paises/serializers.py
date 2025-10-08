from rest_framework import serializers
from .models import Pais, Onu

class PaisSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pais
        fields = '__all__'

class OnuSerializer(serializers.ModelSerializer):
    class Meta:
        model = Onu
        fields = '__all__'