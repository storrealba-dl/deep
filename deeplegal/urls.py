from django.urls import path
from managers.views import *

urlpatterns = [
#    path('admin/', admin.site.urls),
  path('users/', UsersView.as_view(), name='test'),
  path('users/<int:id>/', UsersView.as_view(), name='test'),
  path('menus/', MenusView.as_view(), name='test'),
  path('menus/<int:id>/', MenusView.as_view(), name='test'),
  path('menusitems/', MenusItemsView.as_view(), name='test'),
  path('menusitems/<int:id>/', MenusItemsView.as_view(), name='test'),
  path('companies/', CompaniesView.as_view(), name='test'),
  path('companies/<int:id>/', CompaniesView.as_view(), name='test'),
  path('companies/<int:company_id>/ruts/', RutsView.as_view(), name='test'),
  path('companies/<int:company_id>/ruts/<int:id>/', RutsView.as_view(), name='test'),
  path('companies/<int:company_id>/teams/', TeamsView.as_view(), name='test'),
  path('companies/<int:company_id>/teams/<int:id>/', TeamsView.as_view(), name='test'),
]
