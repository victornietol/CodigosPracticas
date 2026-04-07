# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from django.contrib.auth.models import AbstractUser


class Libro(models.Model):
    titulo = models.CharField(max_length=200)
    anio_publicacion = models.TextField()  # This field type is a guess.
    no_paginas = models.PositiveSmallIntegerField()
    edicion = models.CharField(max_length=100)
    id_editorial = models.ForeignKey('Editorial', models.DO_NOTHING, db_column='id_editorial')
    activo = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'libro'


class Autor(models.Model):
    nombre = models.CharField(max_length=50)
    apellido_p = models.CharField(max_length=50)
    apellido_m = models.CharField(max_length=50, blank=True, null=True)
    activo = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'autor'
        unique_together = (('nombre', 'apellido_p', 'apellido_m'),)


class Editorial(models.Model):
    nombre = models.CharField(unique=True, max_length=70)
    activo = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'editorial'


###### Para roles de usuario
class User(AbstractUser):
    ROLE_CHOICES = (
        ('admin', 'Admin'),
        ('cliente', 'Cliente'),
        ('vendedor', 'Vendedor'),
    )

    role = models.CharField(max_length=20, choices=ROLE_CHOICES, default='cliente')
