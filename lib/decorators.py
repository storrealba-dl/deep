from functools import wraps
from django.http import HttpResponseRedirect

def admin_required(fn):
  @wraps(fn)
  def wrap(request, *args, **kwargs):
    if request.cSecMgr.bAdmin:
      return fn(request, *args, **kwargs)
    return HttpResponseRedirect("/")
  return wrap
