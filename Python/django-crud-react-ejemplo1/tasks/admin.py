from django.contrib import admin
from .models import Task

# Register your models here.
admin.site.register(Task) # Indica que proyectos se van a mostrar en el panel de administrador
