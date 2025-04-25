from .models import Project
from rest_framework import viewsets, permissions
from .serializers import ProjectSerializer

class ProjectViewSet(viewsets.ModelViewSet):
    '''Que consultas se van a poder hacer'''
    queryset = Project.objects.all() # Consulta todos los datos de la tabla
    permission_classes = [permissions.AllowAny] # quien puede solicitar datos
    serializer_class = ProjectSerializer