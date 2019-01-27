from django.utils.deprecation import MiddlewareMixin
from managers.security import SecurityMgr, globals
#from django.urls import resolve
#from django.http import HttpResponse
from django.shortcuts import redirect, render

class DeepLegalMiddleware(MiddlewareMixin):
  def process_view(self, request, view_func, view_args, view_kwargs):
    if request.resolver_match.url_name == "restLogin":
      return None

    if request.resolver_match.url_name == "login":
      return None

    if not globals.cSecMgr.bLogged:
      return redirect("/login/")
    return None

  def process_request(self, request):
    SecurityMgr(request)
    return None

