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


# class products(models.Model):
#     name = models.CharField(max_length=255)
#     image_paths = models.FileField(upload_to='images/')

#     def get_image_paths_list(self):
#         return self.image_paths.split(',')

#     def set_image_paths_list(self, image_paths_list):
#         self.image_paths = ','.join(image_paths_list)

# from django.db import models

# class products(models.Model):
#     image = models.ImageField(upload_to='images/')  # This will save images in a 'images' subdirectory within your media root

#     def __str__(self):
#         return self.image.name


# models.py
from django.db import models

class products(models.Model):
    image = models.ImageField(upload_to='images/')
    product_name = models.CharField(max_length=50)
    quanteaty = models.IntegerField(null=True)
    price = models.IntegerField(null=True)
