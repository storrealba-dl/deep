from django.urls import path
from . import views

app_name = 'auth'

urlpatterns = [
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('r/login/', views.restLogin, name='restLogin'),
    path('r/logout/', views.restLogin, name='restLogout'),
]

