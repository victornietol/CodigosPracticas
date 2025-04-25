from rest_framework import serializers
from .models import Project

class ProjectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Project
        fields = ('id','titulo', 'descripcion', 'tecnologia', 'fecha_creacion') # campos que podran ser consultados
        read_only_fields = ('fecha_creacion',) # campo solo de lectura (debe ser una tupla)