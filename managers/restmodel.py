from django.conf import settings
from django.views import View
from django.forms.models import model_to_dict
from django.http import HttpResponse, JsonResponse, QueryDict
from itertools import chain
import syslog

class RestModelView(View):
  MSG_UNIMPLEMENTED = "Operation unimplemented"
  MSG_SUCCESS = "The operation ended successfully"
  MSG_DELETED = "Object deleted successfully"
  MSG_NOT_FOUND = "Object does not exists"
  MSG_NOT_DELETED = "Object was not deleted"
  MSG_NOT_UPDATED = "Object was not updated"

  params = {}
  obj = None
  searchField = "name"
  hideFields = []
  forbidenFields = [ "id" ]

  def setFilter(self, data):
    return True

  def jsonResponse(self, jsonObj, status=200):
    if settings.DEBUG:
      return JsonResponse(jsonObj, safe=False, json_dumps_params={"indent":4}, status=status)
    return JsonResponse(jsonObj, safe=False, status=status)

  def updateFields(self, data, params):
    try:
      for f in data._meta.fields:
        if not f.name in self.forbidenFields:
          if f.name in params:
            setattr(data, f.name, params[f.name])
      data.save()
      return True
    except:
      pass
    return False

  def removeFields(self, data):
    if self.hideFields:
      for f in self.hideFields:
        if f in data:
          del data[f]
    return data

  def expandFields(self, obj, data):
    return obj

  def dictOf(self, data):
    opts = data._meta
    obj = {}
    for f in chain(opts.concrete_fields, opts.private_fields):
      if not getattr(f, 'editable', False):
        continue
      if self.hideFields and f.column in self.hideFields:
        continue
      obj[f.column] = f.value_from_object(data)
    return self.expandFields(obj, data)

  def dispatch(self, request, *args, **kwargs):
    if self.obj:

      self.params = request.GET.copy()
      if request.method == "POST":
        self.params.update(request.POST.copy())
      elif request.method == "PUT":
        request.method = 'POST'
        request._load_post_and_files()
        request.method = 'PUT'
        self.params.update(request.POST.copy())

      self.params.update(kwargs)
      self.setFilter(request)
      return super(RestModelView, self).dispatch(request, *args, **kwargs)
    jsonObj = None
    return self.jsonResponse(jsonObj, status=404)

  def get(self, request, *args, **kwargs):
    if "id" in kwargs:
      return self.read(request, *args, **kwargs)
    return self.list(request, *args, **kwargs)

  def post(self, request, *args, **kwargs):
    return self.create(request, *args, **kwargs)

  def delete(self, request, *args, **kwargs):
    return self.destroy(request, *args, **kwargs)

  def put(self, request, *args, **kwargs):
    return self.update(request, *args, **kwargs)

  def list(self, request, *args, **kwargs):
    draw = 1
    start = 0
    length = 10
    data = []

    querySet = self.obj.all()
    if "search[value]" in self.params:
      filter = self.searchField + "__icontains"
      querySet = querySet.filter(**{ filter: self.params["search[value]"] })

    total = querySet.count()
    if "draw" in self.params:
      draw = int(self.params["draw"])

    if "start" in self.params:
      start = int(self.params["start"])

    if "length" in self.params:
      length = int(self.params["length"])

    end = start + length
    for u in querySet[start:end]:
      o = self.dictOf(u)
      data.append(o)

    response = { "data": data, "draw": draw, "recordsTotal": total, "recordsFiltered": total }
    return self.jsonResponse(jsonObj=response)

  def read(self, request, *args, **kwargs):
    try:
      data = self.dictOf(self.obj.get(id=kwargs["id"]))
      return self.jsonResponse(jsonObj=data)
    except:
      pass
    return self.jsonResponse(jsonObj={"result": self.MSG_NOT_FOUND, "status": 404})

  def create(self, request, *args, **kwargs):
    obj = self.obj.model()
    for f in obj._meta.fields:
      if f.column in self.params:
        setattr(obj, f.column, self.params[f.column])
    obj.save()
    output = self.dictOf(obj)
    output.update({"result": self.MSG_SUCCESS, "status": 200})
    return self.jsonResponse(jsonObj=output, status=200)

  def destroy(self, request, *args, **kwargs):
    try:
      data = self.obj.get(id=kwargs["id"])
    except:
      data = None
    if data:
      # trigger user delete
      #data.delete()
      return self.jsonResponse(jsonObj={"result": self.MSG_DELETED, "status": 200}, status=200)
    return self.jsonResponse(jsonObj={"result": self.MSG_NOT_FOUND, "status": 404}, status=200)

  def update(self, request, *args, **kwargs):
    try:
      data = self.obj.get(id=kwargs["id"])
      if self.updateFields(data, self.params):
        return self.jsonResponse(jsonObj={"result": self.MSG_SUCCESS, "status": 200}, status=200)
      else:
        return self.jsonResponse(jsonObj={"result": self.MSG_NOT_UPDATED, "status": 500}, status=200)
    except:
      pass
    return self.jsonResponse(jsonObj={"result": self.MSG_NOT_FOUND, "status": 404}, status=200)

