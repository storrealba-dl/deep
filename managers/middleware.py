from django.utils.deprecation import MiddlewareMixin
from django.urls import resolve
from django.http import HttpResponse
from django.shortcuts import redirect, render

class DeepLegalMiddleware(MiddlewareMixin):
  def process_view(self, request, view_func, view_args, view_kwargs):
    return None

  def process_request(self, request):
    return None

