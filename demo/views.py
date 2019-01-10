from django.shortcuts import render

# Create your views here.
def default(request):
  context = {'app': request.resolver_match.app_name}
  return render(request, "demo/demo.html", context)


