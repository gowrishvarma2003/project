# Generated by Django 4.2.2 on 2023-11-27 09:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='products',
            name='sellers',
            field=models.BigIntegerField(null=True),
        ),
    ]
