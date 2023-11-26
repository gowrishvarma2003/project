from rest_framework import serializers
from .models import users,sellers,products,carts
from django import forms

class userserializer(serializers.ModelSerializer):
    class Meta:
        model = users
        fields = [
            'first_name',
            'last_name',
            'phone',
            'pincode',
            'city',
            'street',
            'district',
            'state'
        ]

class sellerserializer(serializers.ModelSerializer):
    class Meta:
        model = sellers
        fields = [
            'seller_name',
            'phone',
            'pincode',
            'city',
            'street',
            'district',
            'state'
        ]

# class productsserializer(serializers.ModelSerializer):
#     class Meta:
#         model = products
#         fields = [
#             'name',
#             'image_paths'
#         ]

# serializers.py
from rest_framework import serializers
# from .models import ImageModel

class ImageModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = products
        fields = ['id','image','product_name','quanteaty','price']


from rest_framework import serializers
from .models import products

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = products
        fields = '__all__'

class cartserializer(serializers.ModelSerializer):
    class Meta:
        model = carts
        fields = [
            'user',
            'quantity',
            'price',
            'product_name',
            'image'
        ]   



