from rest_framework import serializers
from .models import users,sellers

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