# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Onu(models.Model):
    pais = models.CharField(db_column='PAIS', max_length=50, blank=True, primary_key=True)  # Field name made lowercase.
    continente = models.CharField(db_column='CONTINENTE', max_length=30, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'onu'


class Pais(models.Model):
    pais = models.CharField(db_column='PAIS', max_length=50, blank=True, primary_key=True)  # Field name made lowercase.
    atletas = models.IntegerField(db_column='ATLETAS', blank=True, null=True)  # Field name made lowercase.
    oro = models.IntegerField(db_column='ORO', blank=True, null=True)  # Field name made lowercase.
    plata = models.IntegerField(db_column='PLATA', blank=True, null=True)  # Field name made lowercase.
    bronce = models.IntegerField(db_column='BRONCE', blank=True, null=True)  # Field name made lowercase.
    continente = models.CharField(db_column='CONTINENTE', max_length=30, blank=True, null=True)  # Field name made lowercase.
    habitantes = models.BigIntegerField(db_column='HABITANTES', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'pais'
