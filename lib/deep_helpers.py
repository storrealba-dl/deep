from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

from managers.security import globals

def renderTemplate(request, tpl, obj=None):
  if not obj:
    obj = globals.cSecMgr.dict()
  return render(request, tpl, obj)

