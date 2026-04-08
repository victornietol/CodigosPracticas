from rest_framework import serializers
from django.contrib.auth import get_user_model
from django.contrib.auth.password_validation import validate_password

User = get_user_model()

# CREACION DE USUARIOS NUEVOS
class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'role']

    ### SE PUEDEN DEFINIR VALIDACIONES PARA LOS CAMPOS
    def validate_password(self, value):
        validate_password(value) # aplica validaciones
        return value

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user