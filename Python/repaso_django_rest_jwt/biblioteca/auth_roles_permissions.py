from rest_framework.permissions import BasePermission
from rest_framework.exceptions import NotAuthenticated, PermissionDenied

### OPC 1. VERIFICAR SOLO ROL (AUTORIZACION) Y LA VERIFICACION DE LA AUTENTICACION SE INDICA EN LA VISTA
###        EN LA VISTA DEBE INCLUIRSE IsAuthenticated aparte de la clase para verificar roles
class HasRole(BasePermission):
    allowed_roles = []
    def has_permission(self, request, view):
        return request.user.role in self.allowed_roles
    


### OPC 2. VERIFICAR AUTENTICACION Y PERMISOS DEL ROL (AUTORIZACION). MANDA MENSAJE PERSONALIZADO
class IsAuthenticatedAndRole(BasePermission):
    allowed_roles = []
    def has_permission(self, request, view):
        if not request.user or not request.user.is_authenticated:
            raise NotAuthenticated("No se proporcionaron credenciales o son inválidas.")
        if request.user.role not in self.allowed_roles:
            raise PermissionDenied("Falta de autorizacion.")



## CADA CLASE HEREDA SEGUN LA FORMA DE AUTENTICAR Y AUTORIZAR (HasRole o IsAuthenticatedAndRole)
class IsAdmin(HasRole):
    allowed_roles = ['admin']

class IsVendedorOrCliente(HasRole):
    allowed_roles = ['vendedor', 'cliente']

class AllowAllRoles(HasRole):
    allowed_roles = ['admin', 'vendedor', 'cliente']




