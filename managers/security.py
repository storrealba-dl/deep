from passlib.hash import bcrypt
from auth.models import *
from datetime import *
from lib.deep_utils import *
import threading

globals = threading.local()

class SecurityMgr():
  
  def __init__(self, request):
    globals.cSecMgr = self

    request.cSecMgr = self
    self.bSuper = False
    self.bAdmin = False
    self.bLogged = False
    self.cUser = None
    self.cCompany = None
    self.cMenu = None
    self.bForcePw = True

    self.request = request
    self.session = request.session

    self.app_name = None
    self.url_name = None

    if self.session.get("logged_in", 0):
      try:
        cUser = Users.objects.get(id=self.session.get("uid"))
        if cUser:
          self.setLogin(cUser)
      except:
        pass

  def dict(self):
    r = {
      
    }
    return r

  def setLogin(self, cUser):
    if cUser:
      self.session["logout"] = 0
      self.session["logged_in"] = 1
      self.session["uid"] = cUser.id
      self.session["cid"] = cUser.company_id

      self.userLetter = signature(cUser.name)
      self.userTitle = cUser.name.title()
      self.cUser = cUser
      self.cCompany = cUser.company
      self.cMenu = cUser.menu
      self.bLogged = True
      self.bAdmin = cUser.role_id >= 1000
      self.bSuper = cUser.role_id == 99999

      self.app_name = self.request.resolver_match.app_name
      self.url_name = self.request.resolver_match.url_name

    return self.bLogged

  def doLogin(self, email, password, remember):
    self.doLogout()
    cUser = self.authUser(email, password)

    if remember:
      self.request.session.set_expiry(999999999)
    else:
      self.request.session.set_expiry(0)

    if not cUser:
      return False

    return self.setLogin(cUser)

  def doLogout(self):
    self.request.session.flush()
    self.bLogged = False
    self.bAdmin = False
    self.bSuper = False
    self.cUser = None
    return True

  def authUser(self, email, password):
    try:
      cUser = Users.objects.get(email=email)
      if self.checkPass(password, cUser.password):
        return cUser
    except:
      pass
    return None

  def checkPass(self, password, passwordHash):
    return bcrypt.verify(password, passwordHash)

  def encryptPass(self, password):
    return bcrypt.encrypt(password, rounds=11)


  def getModules(self):
    return self.cMenu.items.filter(menutype__lte=2)

  def getConfigMenus(self):
    return MenusItems.objects.filter(level__lte=self.cUser.role_id, menutype__gte=10)
