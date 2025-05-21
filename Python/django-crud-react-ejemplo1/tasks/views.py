from django.shortcuts import render
from rest_framework import viewsets
from .serializer import TaskSerializer
from .models import Task

# Create your views here.
class TaskView(viewsets.ModelViewSet): # Asi se generan automaticamente las operaciones del CRUD
    serializer_class = TaskSerializer
    queryset = Task.objects.all()