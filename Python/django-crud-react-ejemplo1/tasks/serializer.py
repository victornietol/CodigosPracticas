from rest_framework import serializers
from .models import Task

class TaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Task # Indica a que modelo hace referencia
        # fields = ("id", "title", "description", "done") # Campos a mostrar (forma manual de declarar)
        fields = "__all__" # Indica que se deben mostrar todos (serializa todos)
