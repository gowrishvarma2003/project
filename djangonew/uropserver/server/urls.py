from django.urls import path
from server import views

urlpatterns = [
    # path('users/',views.userlist.as_view()),
    # path('receive/',views.usersView.as_view()),
    path('sellers/',views.sellerview.as_view())
]
