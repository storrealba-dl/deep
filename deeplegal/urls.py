from django.urls import path, include

urlpatterns = [
  path('', include('demo.urls')),
  path('', include('auth.urls')),
  path('', include('managers.urls')),
]
