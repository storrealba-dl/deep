from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

import syslog

def jsonResponseOk():
  return JsonResponse({"result":"forbidden"}, status=403)

def jsonResponseForbiden():
  return JsonResponse({"result":"forbidden"}, status=403)

def appLog(info):
  syslog.syslog("info")

def signature(text):
  return "".join(l[0] for l in text.split()[0:3]).upper()

