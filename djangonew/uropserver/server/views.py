from django.shortcuts import render
from .serializers import userserializer,sellerserializer,cartserializer
from .models import users,sellers,products,carts,orders
from rest_framework.generics import ListAPIView
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import users
from django.views.decorators.csrf import csrf_exempt
from django.middleware.csrf import get_token
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from .serializers import ImageModelSerializer

# class userlist(ListAPIView):
#     queryset = users.objects.all()
#     serializer_class = userserializer

class usersView(APIView):
    def post(self, request, format=None):
        print("hear")
        print(request.data)
        serializer = userserializer(data=request.data)
        if serializer.is_valid():
            # Process the data here
            data = serializer.validated_data
            print("cfgv")
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
            lon_g = data.get('lon')
            lat_g = data.get('lat')
            new_Data = users(first_name=first_name_g,last_name=last_name_g,phone= phone_g,pincode=pincode_g,city=city_g,street=street_g,district=district_g,state=state_g,lon=lon_g,lat=lat_g)
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
            lon_g = sellers_data.get('lon')
            lat_g = sellers_data.get('lat')
            new_Data = sellers(seller_name = sellername_g,phone= phone_g,pincode=pincode_g,city=city_g,street=street_g,district=district_g,state=state_g,lon=lon_g,lat=lat_g)
            new_Data.save()
            return Response({'message': 'Data received successfully'}, status=status.HTTP_200_OK)
        return Response(seller_serializer.errors, status=status.HTTP_400_BAD_REQUEST)





from .models import products  # Replace with your model

class save_product(APIView):
    parser_classes = (MultiPartParser, FormParser)

    def post(self, request, format=None):
        serializer = ImageModelSerializer(data=request.data)
        product_name = request.data.get('product_name')
        quantity = request.data.get('quanteaty')
        price = request.data.get('price')

        if serializer.is_valid():
            serializer.validated_data['product_name'] = product_name
            serializer.validated_data['quanteaty'] = quantity
            serializer.validated_data['price'] = price
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

def get_csrf_token(request):
    csrf_token = get_token(request)
    print(csrf_token)
    return JsonResponse({'csrfToken': csrf_token})


# from rest_framework import generics
# from .models import products
# from .serializers import ProductSerializer

# class ProductList(generics.ListCreateAPIView):
#     queryset = products.objects.all()
#     serializer_class = ProductSerializer


from rest_framework.views import APIView
from rest_framework.response import Response
from .models import products
from .serializers import ImageModelSerializer

class ProductList(APIView):
    def get(self, request):
        products_data = products.objects.all()
        serializer = ImageModelSerializer(products_data, many=True)
        return Response(serializer.data)

from rest_framework.views import APIView
from rest_framework.response import Response
from .models import carts
from .serializers import cartserializer

class cartlist(APIView):
    def get(self, request):
        cart_data = carts.objects.all()
        serializer = cartserializer(cart_data, many=True)
        return Response(serializer.data)

class cartView(APIView):
    def post(self, request, format=None):
        cart_serializer = cartserializer(data=request.data)
        if cart_serializer.is_valid():
            cart_data = cart_serializer.validated_data
            user_g = cart_data.get('user')
            product_name_g = cart_data.get('product_name')
            image_g = cart_data.get('image')
            quantity_g = cart_data.get('quantity')
            price_g = cart_data.get('price')
            new_Data = carts(user=user_g,image=image_g,product_name=product_name_g,quantity=quantity_g,price=price_g)
            new_Data.save()
            return Response({'message': 'Data received successfully'}, status=status.HTTP_200_OK)
        return Response(cart_serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class cart_data(APIView):
    def get(self, request, user_id):
        user_products = carts.objects.filter(user=user_id)  # Query products for a specific user
        serializer = cartserializer(user_products, many=True)
        # print(serializer.data)
        return Response(serializer.data)

class user_orders_data(APIView):
    def get(self, request, user_id):
        user_products = carts.objects.filter(user=user_id)  # Query products for a specific user
        serializer = cartserializer(user_products, many=True)
        print(serializer.data)
        return Response(serializer.data)

from geopy.distance import geodesic

class userOrderView(APIView):
    def calculate_distance(self, lat1, lon1, lat2, lon2):
        return geodesic((lat1, lon1), (lat2, lon2)).kilometers

    def get_nearest_seller(self, user_lat, user_lon, product_name, price):
        seller_phones = products.objects.filter(product_name=product_name, price=price).values_list('seller', flat=True)
        sellers = sellers.objects.filter(phone__in=seller_phones)
        min_distance = float('inf')
        nearest_seller = None
        for seller in sellers:
            distance = self.calculate_distance(user_lat, user_lon, seller.lat, seller.lon)
            if distance < min_distance:
                min_distance = distance
                nearest_seller = seller
        return nearest_seller

    def post(self, request, format=None):
        print(request.data)
        data = request.data

        user_details = data.get('userDetails', {})
        products = data.get('products', [])

        # Save user details (assuming you have a separate model for user details)
        # Replace UserDetailModel with your actual user detail model
        # Assuming user phone number is being stored
        user_phone_number = user_details.get('user')
        # ...

        # Save products to the database
        for product_data in products:
            # select the seller who has the product and is nearest to the user
            product = orders(
                user=user_phone_number,
                seller=self.get_nearest_seller(user_details.get('lat'), user_details.get('lon'), product_data.get('productName'), product_data.get('price').get('phone'),
                quantity=product_data.get('quantity'),
                price=product_data.get('price'),
                productName=product_data.get('productName'),
                image=product_data.get('image')
            )
            product.save()
            # remove a product from the cart
            cart_product = carts.objects.filter(user=user_phone_number, product_name=product_data.get('productName'), price=product_data.get('price')).first()
            if cart_product:
                cart_product.delete()

        return Response({'message': 'Products and user details saved successfully'}, status=status.HTTP_200_OK)
        # return Response({'message': 'Data received successfully'}, status=status.HTTP_200_OK)
#         cart_data = cart_serializer.validated_data
#         user_g = cart_data.get('user')
#         product_name_g = cart_data.get('product_name')
#         image_g = cart_data.get('image')
#         quantity_g = cart_data.get('quantity')
#         price_g = cart_data.get('price')
#         new_Data = carts(user=user_g,image=image_g,product_name=product_name_g,quantity=quantity_g,price=price_g)
#         new_Data.save()
#         return Response({'message': 'Data received successfully'}, status=status.HTTP_200_OK)
#         return Response(cart_serializer.errors, status=status.HTTP_400_BAD_REQUEST)



