# Generated by Django 4.2.2 on 2023-11-24 21:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0004_alter_products_price_carts'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='carts',
            name='user_id',
        ),
    ]
