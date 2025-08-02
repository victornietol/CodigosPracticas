# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class AuthtokenToken(models.Model):
    key = models.CharField(primary_key=True, max_length=40)
    created = models.DateTimeField()
    user = models.OneToOneField(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'authtoken_token'


class Bitacora(models.Model):
    fecha = models.DateTimeField()
    usuario = models.CharField(max_length=70)
    tabla = models.CharField(max_length=50)
    sentencia = models.CharField(max_length=70)
    accion = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'bitacora'


class Centrales(models.Model):
    id_central = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=14)

    class Meta:
        managed = False
        db_table = 'centrales'


class Compania(models.Model):
    id_compania = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=70)

    class Meta:
        managed = False
        db_table = 'compania'


class ConsumidoresCat(models.Model):
    id_consumidor = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=13)

    class Meta:
        managed = False
        db_table = 'consumidores_cat'


class Distribuye(models.Model):
    id_subestacion = models.ForeignKey('Subestacion', models.DO_NOTHING, db_column='id_subestacion')
    id_zona = models.ForeignKey('Zona', models.DO_NOTHING, db_column='id_zona')
    fecha_inic = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'distribuye'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Entidades(models.Model):
    id_entidades = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=50)
    codigo = models.IntegerField(unique=True)
    abreviatura = models.CharField(unique=True, max_length=4)

    class Meta:
        managed = False
        db_table = 'entidades'


class EntregarEnergia(models.Model):
    id_productor = models.ForeignKey('Productor', models.DO_NOTHING, db_column='id_productor')
    id_estacion = models.ForeignKey('Estacion', models.DO_NOTHING, db_column='id_estacion')
    energia_entregada = models.IntegerField()
    fecha = models.DateField()

    class Meta:
        managed = False
        db_table = 'entregar_energia'


class Estacion(models.Model):
    id_estacion = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=70)
    num_transformadores = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'estacion'


class Hidroelectrica(models.Model):
    id_hidroelectrica = models.AutoField(primary_key=True)
    id_productor = models.ForeignKey('Productor', models.DO_NOTHING, db_column='id_productor')
    id_central = models.ForeignKey(Centrales, models.DO_NOTHING, db_column='id_central')
    ocupacion = models.CharField(max_length=200)
    capacidad_max = models.FloatField()
    num_turbinas = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'hidroelectrica'
        unique_together = (('id_hidroelectrica', 'id_productor'),)


class InfoConsumidor(models.Model):
    id_zona = models.ForeignKey('Zona', models.DO_NOTHING, db_column='id_zona')
    id_consumidor = models.ForeignKey(ConsumidoresCat, models.DO_NOTHING, db_column='id_consumidor')
    consumo_medio = models.FloatField()
    num_consumidores = models.IntegerField()
    fecha = models.DateField()

    class Meta:
        managed = False
        db_table = 'info_consumidor'
        unique_together = (('id_zona', 'id_consumidor', 'fecha'),)


class IntercambiaEnergia(models.Model):
    id_red = models.ForeignKey('Red', models.DO_NOTHING, db_column='id_red')
    id_intercambia_con = models.ForeignKey('Red', models.DO_NOTHING, db_column='id_intercambia_con', related_name='intercambiaenergia_id_intercambia_con_set')
    energia_inter = models.FloatField()
    fecha = models.DateField()

    class Meta:
        managed = False
        db_table = 'intercambia_energia'


class Linea(models.Model):
    id_linea = models.AutoField(primary_key=True)
    id_red = models.ForeignKey('Red', models.DO_NOTHING, db_column='id_red')
    num_linea = models.IntegerField()
    longitud = models.FloatField()

    class Meta:
        managed = False
        db_table = 'linea'
        unique_together = (('num_linea', 'id_red'),)


class Nuclear(models.Model):
    id_nuclear = models.AutoField(primary_key=True)
    id_productor = models.ForeignKey('Productor', models.DO_NOTHING, db_column='id_productor')
    id_central = models.ForeignKey(Centrales, models.DO_NOTHING, db_column='id_central')
    num_reactores = models.IntegerField()
    vol_plutonio = models.FloatField()
    vol_residuos = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'nuclear'
        unique_together = (('id_nuclear', 'id_productor'),)


class Pais(models.Model):
    id_pais = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=70)

    class Meta:
        managed = False
        db_table = 'pais'


class Porte(models.Model):
    id_porte = models.AutoField(primary_key=True)
    id_transportista = models.ForeignKey('Transportista', models.DO_NOTHING, db_column='id_transportista')
    descripcion = models.CharField(max_length=250, blank=True, null=True)
    fecha_registro = models.DateTimeField()
    fecha_realizacion = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'porte'


class Productor(models.Model):
    id_productor = models.AutoField(primary_key=True)
    razon_social = models.CharField(unique=True, max_length=70)
    rfc = models.CharField(unique=True, max_length=13)
    produccion_med = models.FloatField()
    produccion_max = models.FloatField()
    id_entidades = models.ForeignKey(Entidades, models.DO_NOTHING, db_column='id_entidades')
    fecha_func = models.DateField()

    class Meta:
        managed = False
        db_table = 'productor'


class ProductorCentrales(models.Model):
    id_productor = models.ForeignKey(Productor, models.DO_NOTHING, db_column='id_productor')
    id_central = models.ForeignKey(Centrales, models.DO_NOTHING, db_column='id_central')
    fecha_fundacion = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'productor_centrales'


class Red(models.Model):
    id_red = models.AutoField(primary_key=True)
    id_estacion = models.ForeignKey(Estacion, models.DO_NOTHING, db_column='id_estacion')
    num_red = models.IntegerField(unique=True)

    class Meta:
        managed = False
        db_table = 'red'


class RedCompania(models.Model):
    id_red = models.ForeignKey(Red, models.DO_NOTHING, db_column='id_red')
    id_compania = models.ForeignKey(Compania, models.DO_NOTHING, db_column='id_compania')
    fecha_pertenencia = models.DateField()

    class Meta:
        managed = False
        db_table = 'red_compania'
        unique_together = (('id_red', 'id_compania', 'fecha_pertenencia'),)


class Solar(models.Model):
    id_solar = models.AutoField(primary_key=True)
    id_productor = models.ForeignKey(Productor, models.DO_NOTHING, db_column='id_productor')
    id_central = models.ForeignKey(Centrales, models.DO_NOTHING, db_column='id_central')
    paneles_solares = models.FloatField()
    horas_sol = models.IntegerField()
    tipo = models.CharField(max_length=13)

    class Meta:
        managed = False
        db_table = 'solar'
        unique_together = (('id_solar', 'id_productor'),)


class Subestacion(models.Model):
    id_subestacion = models.AutoField(primary_key=True)
    id_linea = models.ForeignKey(Linea, models.DO_NOTHING, db_column='id_linea')
    nombre = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'subestacion'
        unique_together = (('id_subestacion', 'nombre'),)


class Suministrador(models.Model):
    id_suministrador = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    id_pais = models.ForeignKey(Pais, models.DO_NOTHING, db_column='id_pais')

    class Meta:
        managed = False
        db_table = 'suministrador'


class Termica(models.Model):
    id_termica = models.AutoField(primary_key=True)
    id_productor = models.ForeignKey(Productor, models.DO_NOTHING, db_column='id_productor')
    id_central = models.ForeignKey(Centrales, models.DO_NOTHING, db_column='id_central')
    num_hornos = models.IntegerField()
    vol_carbon = models.FloatField()
    vol_gases = models.FloatField()

    class Meta:
        managed = False
        db_table = 'termica'
        unique_together = (('id_termica', 'id_productor'),)


class Transportista(models.Model):
    id_transportista = models.AutoField(primary_key=True)
    razon_social = models.CharField(unique=True, max_length=70)
    rfc = models.CharField(unique=True, max_length=13)

    class Meta:
        managed = False
        db_table = 'transportista'


class Ventas(models.Model):
    id_venta = models.AutoField(primary_key=True)
    id_suministrador = models.ForeignKey(Suministrador, models.DO_NOTHING, db_column='id_suministrador')
    id_nuclear = models.ForeignKey(Nuclear, models.DO_NOTHING, db_column='id_nuclear')
    id_porte = models.ForeignKey(Porte, models.DO_NOTHING, db_column='id_porte')
    descripcion = models.CharField(max_length=250, blank=True, null=True)
    cantidad_plutonio = models.FloatField()
    fecha = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ventas'
        unique_together = (('id_venta', 'id_porte'),)


class Zona(models.Model):
    id_zona = models.AutoField(primary_key=True)
    id_entidades = models.ForeignKey(Entidades, models.DO_NOTHING, db_column='id_entidades')
    nombre = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'zona'
        unique_together = (('id_zona', 'nombre'),)
