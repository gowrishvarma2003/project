from django.urls import path
from server import views
from .views import get_csrf_token
from django.conf import settings
from django.conf.urls.static import static  

urlpatterns = [
    # path('users/',views.userlist.as_view()),
    path('receive/',views.usersView.as_view()),
    path('sellers/',views.sellerview.as_view()),
    path('products/',views.save_product.as_view()),
    path('get-csrf-token/', get_csrf_token, name='get-csrf-token'),
    # path('get_data/',get_data,name = 'get_data')
    path('send/', views.ProductList.as_view(), name='product-list'),
    path('cart/', views.cartView.as_view(), name='cart'),
    path('cart_data/<int:user_id>/', views.cart_data.as_view(), name='cart_data'),
    path('order/', views.userOrderView.as_view(), name='order'),
    path('seller_orders/<int:seller_id>/', views.OrdersBySeller.as_view(), name='seller_orders'),

]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)    