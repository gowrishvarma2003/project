from django.contrib import admin
from .models import users

# Register your models here.

@admin.register(users)
class useradmin(admin.ModelAdmin):
    list_display = [
            'first_name',
            'last_name',
            'phone',
            'pincode',
            'city',
            'street',
            'district',
            'state'
        ]