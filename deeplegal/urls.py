from django.urls import path, include
from django.conf.urls.static import static

urlpatterns = [
  path('', include('demo.urls')),
  path('', include('auth.urls')),
  path('', include('managers.urls')),
  path('', include('admin.urls')),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
