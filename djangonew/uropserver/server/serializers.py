from rest_framework import serializers
from .models import users,sellers,products,carts,orders
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
            'state',
            'lon',
            'lat'
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
            'state',
            'lon',
            'lat'
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
    image = serializers.ImageField(use_url=True)  # Assuming 'image' is the field storing the image path in the 'products' model
    class Meta:
        model = products
        fields = [
            'id','image','product_name','quanteaty','price','seller'
        ]

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

class orderserializer(serializers.ModelSerializer):
    class Meta:
        model = orders
        fields = [
            'user',
            'seller',
            'productName',
            'quantity',
            'price',
            'image',
            'status',
            # 'date'
        ]



