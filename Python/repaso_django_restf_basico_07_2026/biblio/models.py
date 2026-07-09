from django.db import models

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
