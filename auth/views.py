from django.shortcuts import render, redirect
from managers.security import globals
from lib.deep_utils import *

# Create your views here.
def login(request):
  context = {'app': request.resolver_match.app_name}
  return render(request, "login/login.html", context)

def restLogin(request):
  if request.method == "POST":
    from django.http import HttpResponse, JsonResponse

    return HttpResponse(globals.cSecMgr.doLogin(request.POST["user"], request.POST["pass"], (request.POST["remember"] == "true")))
    if globals.cSecMgr.doLogin(request.POST["user"], request.POST["pass"], (request.POST["remember"] == "true")):
      return jsonResponseOk()
    else:
      return jsonResponseForbidden()
  return redirect("/")

def logout(request):
  return restLogout(request)

def restLogout(request):
  globals.cSecMgr.doLogout()
  return redirect("/")
