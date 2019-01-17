from django.shortcuts import render

def users(request):
  context = {'app': request.resolver_match.app_name}
  return render(request, "users/users.html", context)

def companies(request):
  context = {'app': request.resolver_match.app_name}
  return render(request, "companies/companies.html", context)

def teams(request):
  context = {'app': request.resolver_match.app_name}
  return render(request, "teams/teams.html", context)

def ruts(request):
  context = {'app': request.resolver_match.app_name}
  return render(request, "ruts/ruts.html", context)

def menus(request):
  context = {'app': request.resolver_match.app_name}
  return render(request, "menus/menus.html", context)

