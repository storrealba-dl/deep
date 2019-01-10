# Generated by Django 2.1.2 on 2019-01-06 19:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Companies',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('rut', models.CharField(max_length=32)),
                ('name', models.CharField(max_length=64)),
                ('address', models.CharField(max_length=64)),
                ('district', models.CharField(max_length=64)),
                ('city', models.CharField(max_length=64)),
                ('phone', models.CharField(max_length=64)),
                ('email', models.CharField(max_length=64)),
                ('contact_name', models.CharField(max_length=64)),
                ('logo_image', models.BinaryField(blank=True, null=True)),
                ('logo_mimetype', models.CharField(max_length=64)),
            ],
            options={
                'ordering': ['name'],
            },
        ),
        migrations.CreateModel(
            name='Menus',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32)),
                ('access', models.TextField()),
                ('company', models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='auth.Companies')),
            ],
            options={
                'ordering': ['name'],
            },
        ),
        migrations.CreateModel(
            name='MenusItems',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('label', models.CharField(max_length=32)),
                ('parent', models.CharField(max_length=32, null=True)),
                ('title', models.CharField(max_length=32)),
                ('url', models.CharField(max_length=32, null=True)),
                ('menutype', models.IntegerField(default=0)),
                ('position', models.IntegerField(default=0)),
                ('icon', models.CharField(blank=True, max_length=128, null=True)),
                ('icon_active', models.CharField(blank=True, max_length=128, null=True)),
                ('level', models.IntegerField(default=900)),
            ],
            options={
                'ordering': ['position'],
            },
        ),
        migrations.CreateModel(
            name='Plans',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=64, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='Roles',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32, unique=True)),
                ('desc', models.CharField(max_length=32)),
                ('admin', models.BooleanField(default=True)),
                ('visible', models.BooleanField(default=True)),
            ],
            options={
                'ordering': ['id'],
            },
        ),
        migrations.CreateModel(
            name='Ruts',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=64)),
                ('rut', models.CharField(max_length=32)),
                ('company', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='auth.Companies')),
            ],
            options={
                'ordering': ['name'],
            },
        ),
        migrations.CreateModel(
            name='Teams',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32)),
                ('company', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='auth.Companies')),
            ],
        ),
        migrations.CreateModel(
            name='Users',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('email', models.CharField(max_length=64, unique=True)),
                ('password', models.CharField(max_length=64)),
                ('session_id', models.CharField(blank=True, max_length=20, null=True)),
                ('current_ip', models.GenericIPAddressField(blank=True, null=True)),
                ('last_ip', models.GenericIPAddressField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now_add=True)),
                ('rut', models.CharField(blank=True, max_length=32, null=True)),
                ('name', models.CharField(blank=True, max_length=64, null=True)),
                ('address', models.CharField(blank=True, max_length=64, null=True)),
                ('county', models.CharField(blank=True, max_length=64, null=True)),
                ('city', models.CharField(blank=True, max_length=64, null=True)),
                ('phone', models.CharField(blank=True, max_length=64, null=True)),
                ('company', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='auth.Companies')),
                ('menu', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='auth.Menus')),
                ('role', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='auth.Roles')),
            ],
            options={
                'ordering': ['name'],
            },
        ),
        migrations.CreateModel(
            name='Views',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32, unique=True)),
                ('updates', models.TextField()),
            ],
            options={
                'ordering': ['name'],
            },
        ),
        migrations.AddField(
            model_name='users',
            name='view',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='auth.Views'),
        ),
        migrations.AddField(
            model_name='teams',
            name='user',
            field=models.ManyToManyField(blank=True, to='auth.Users'),
        ),
        migrations.AddField(
            model_name='menus',
            name='items',
            field=models.ManyToManyField(blank=True, to='auth.MenusItems'),
        ),
        migrations.AddField(
            model_name='companies',
            name='plan',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='auth.Plans'),
        ),
    ]