from django.shortcuts import render

# Create your views here.
def login(request):
  context = {'app': request.resolver_match.app_name}
  return render(request, "login/login.html", context)

