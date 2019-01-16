from django.conf import settings
from auth.models import *
from managers.restmodel import RestModelView

class UsersView(RestModelView):
  hideFields = [ "password", "session_id" ]
  forbidenFields = [ "password", "session_id", "id" ]
  obj = Users.objects

  def expandFields(self, obj, data):
    obj["company"] = data.company.name
    obj["role"] = data.role.desc
    return obj

  def setFilter(self, data):
    return True

class CompaniesView(RestModelView):
  hideFields = [ "logo_image", "logo_mimetype" ]
  forbidenFields = [ "id" ]
  obj = Companies.objects

  def setFilter(self, data):
    return True

  def expandFields(self, obj, data):
    obj["plan_name"] = data.plan.name
    return obj

class MenusView(RestModelView):
  obj = Menus.objects

  def expandFields(self, obj, data):
    queryset = data.items.filter(menutype__lte=1)
    obj["deleteAllowed"] = Users.objects.filter(menu_id=data.id).count() == 0
    obj["items"] = []
    for i in queryset.all():
      obj["items"].append({"id": i.id, "name": i.title})
    return obj

class MenusItemsView(RestModelView):
  obj = MenusItems.objects
  searchField = "title"

  def setFilter(self, data):
    self.obj = self.obj.filter(menutype__lte=1)
    return True

  def create(self, request, *args, **kwargs):
    return self.jsonResponse(jsonObj={"result": "Unimplemented", "status": 500}, status=500)

  def destroy(self, request, *args, **kwargs):
    return self.jsonResponse(jsonObj={"result": "Unimplemented", "status": 500}, status=500)

  def update(self, request, *args, **kwargs):
    return self.jsonResponse(jsonObj={"result": "Unimplemented", "status": 500}, status=500)

class PlansView(RestModelView):
  obj = Plans.objects

class RutsView(RestModelView):
  obj = Ruts.objects

  def expandFields(self, obj, data):
    obj["company"] = data.company.name
    return obj

class TeamsView(RestModelView):
  obj = Teams.objects

  def expandFields(self, obj, data):
    obj["company"] = data.company.name

    obj["deleteAllowed"] = data.user.count() == 0
    obj["members"] = []
    for u in data.user.all():
      obj["members"].append({"id": u.id, "name": u.name})
    return obj

  def setFilter(self, data):
    self.obj = self.obj.filter(company_id=self.params["company_id"])
    return True

