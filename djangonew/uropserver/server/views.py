from django.shortcuts import render
from .serializers import userserializer,sellerserializer
from .models import users,sellers
from rest_framework.generics import ListAPIView
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import users

# class userlist(ListAPIView):
#     queryset = users.objects.all()
#     serializer_class = userserializer

class usersView(APIView):
    def post(self, request, format=None):
        serializer = userserializer(data=request.data)
        if serializer.is_valid():
            # Process the data here
            data = serializer.validated_data
            print(data)
            # name_got = data.get('first_name')
            # print(name_got)
            first_name_g = data.get('first_name')
            last_name_g = data.get('last_name')
            phone_g = data.get('phone')
            pincode_g = data.get('pincode')
            city_g = data.get('city')
            street_g = data.get('street')
            district_g = data.get('district')
            state_g = data.get('state')
            new_Data = users(first_name=first_name_g,last_name=last_name_g,phone= phone_g,pincode=pincode_g,city=city_g,street=street_g,district=district_g,state=state_g)
            # phone_got = data.get('phone')
            # new_Data = users(name=name_got,phone=phone_got)
            new_Data.save()
            return Response({'message': 'Data received successfully'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class sellerview(APIView):
    def post(self, request, format=None):
        seller_serializer = sellerserializer(data=request.data)
        if seller_serializer.is_valid():
            sellers_data = seller_serializer.validated_data
            sellername_g = sellers_data.get('seller_name')
            phone_g = sellers_data.get('phone')
            pincode_g = sellers_data.get('pincode')
            city_g = sellers_data.get('city')
            street_g = sellers_data.get('street')
            district_g = sellers_data.get('district')
            state_g = sellers_data.get('state')
            new_Data = sellers(seller_name = sellername_g,phone= phone_g,pincode=pincode_g,city=city_g,street=street_g,district=district_g,state=state_g)
            new_Data.save()
            return Response({'message': 'Data received successfully'}, status=status.HTTP_200_OK)
        return Response(seller_serializer.errors, status=status.HTTP_400_BAD_REQUEST)