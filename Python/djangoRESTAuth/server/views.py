from rest_framework.decorators import api_view
from rest_framework.response import Response
from  .serializers import UserSerializer
from rest_framework.authtoken.models import Token
from rest_framework import status
from django.shortcuts import get_object_or_404

from rest_framework.decorators import authentication_classes, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication

from django.contrib.auth.models import User

@api_view(['POST'])
def login(request):
    # Verificar que el usuario exista
    user = get_object_or_404(User, username=request.data["username"])

    if not user.check_password(request.data["password"]): # Si la contraseña no es valida
        return Response(
            {"error":"Invalid password"},
            status=status.HTTP_400_BAD_REQUEST
        )
    
    # Si es valido
    token, created = Token.objects.get_or_create(user=user)
    serializer = UserSerializer(instance=user)

    return Response(
        {"token": token.key, "user": serializer.data},
        status = status.HTTP_200_OK
    )


@api_view(['POST'])
def register(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid(): # En caso de que sea valido
        serializer.save()

        # Guardar usuario
        user = User.objects.get(username=serializer.data["username"])
        user.set_password(serializer.data["password"])
        user.save()

        # Generar token
        token = Token.objects.create(user=user)
        return Response(
            {"token": token.key, "user": serializer.data},
            status=status.HTTP_201_CREATED
        )
    else:
        # Si no es valido
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
@authentication_classes([TokenAuthentication]) # Verifica que el token debe incluirse en el Header de la peticion
@permission_classes([IsAuthenticated])
def profile(request):
    # En caso de estar autenticado
    print(request.user.username)
    serializer = UserSerializer(instance=request.user)
    return Response(
        serializer.data,
        status=status.HTTP_200_OK
    )