# Generated by Django 4.2.2 on 2023-11-27 09:49

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0002_products_sellers'),
    ]

    operations = [
        migrations.RenameField(
            model_name='products',
            old_name='sellers',
            new_name='seller',
        ),
    ]
