from django.urls import path
from .views import *

urlpatterns = [
  path('r/users/', UsersView.as_view(), name='test'),
  path('r/users/<int:id>/', UsersView.as_view(), name='test'),
  path('r/menus/', MenusView.as_view(), name='test'),
  path('r/menus/<int:id>/', MenusView.as_view(), name='test'),
  path('r/menusitems/', MenusItemsView.as_view(), name='test'),
  path('r/menusitems/<int:id>/', MenusItemsView.as_view(), name='test'),
  path('r/companies/', CompaniesView.as_view(), name='test'),
  path('r/companies/<int:id>/', CompaniesView.as_view(), name='test'),
  path('r/companies/<int:company_id>/ruts/', RutsView.as_view(), name='test'),
  path('r/companies/<int:company_id>/ruts/<int:id>/', RutsView.as_view(), name='test'),
  path('r/companies/<int:company_id>/teams/', TeamsView.as_view(), name='test'),
  path('r/companies/<int:company_id>/teams/<int:id>/', TeamsView.as_view(), name='test'),
  path('r/plans/', PlansView.as_view(), name='test'),
  path('r/views/', ViewsView.as_view(), name='test'),
  path('r/roles/', RolesView.as_view(), name='test'),
]

