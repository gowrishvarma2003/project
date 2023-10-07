from django.db import models

# Create your models here.

class users(models.Model):
    first_name = models.CharField(max_length=20)
    last_name = models.CharField(max_length=20)
    phone = models.BigIntegerField()
    pincode = models.IntegerField()
    city = models.CharField(max_length=20,null=True)
    street = models.CharField(max_length=100)
    district = models.CharField(max_length=100, default="")
    state = models.CharField(max_length=100)
    

class sellers(models.Model):
    seller_name = models.CharField(max_length=20)
    phone = models.BigIntegerField()
    pincode = models.IntegerField()
    city = models.CharField(max_length=20,null=True)
    street = models.CharField(max_length=100)
    district = models.CharField(max_length=100, default="")
    state = models.CharField(max_length=100)
