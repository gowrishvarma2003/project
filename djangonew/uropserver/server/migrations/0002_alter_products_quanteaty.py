# Generated by Django 4.2.2 on 2023-10-19 03:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='products',
            name='quanteaty',
            field=models.IntegerField(null=True),
        ),
    ]
