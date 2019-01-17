from django.urls import path
from . import views

app_name = 'admin'

urlpatterns = [
    path('/users/', views.users, name='users'),
    path('/companies/', views.companies, name='companies'),
    path('/teams/', views.teams, name='teams'),
    path('/ruts/', views.ruts, name='ruts'),
    path('/menus/', views.menus, name='menus'),
]


