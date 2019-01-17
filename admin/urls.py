from django.urls import path
from . import views

app_name = 'admin'

urlpatterns = [
    path('a/users/', views.users, name='users'),
    path('a/companies/', views.companies, name='companies'),
    path('a/teams/', views.teams, name='teams'),
    path('a/ruts/', views.ruts, name='ruts'),
    path('a/menus/', views.menus, name='menus'),
]


