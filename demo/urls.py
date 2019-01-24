from django.urls import path
from . import views

app_name = 'demo'

urlpatterns = [
    path('', views.default, name='demo'),
    path('demo/', views.default, name='demo'),
]

