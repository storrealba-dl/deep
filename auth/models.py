from django.db import models
from django.core import serializers

class Roles(models.Model):
  name = models.CharField(unique=True, max_length=32)
  desc = models.CharField(max_length=32)
  admin = models.BooleanField(default=True)
  visible = models.BooleanField(default=True)

  class Meta:
    ordering = ['id']

  def __str__(self):
    return self.name

class Views(models.Model):
  name = models.CharField(unique=True, max_length=32)
  updates = models.TextField()

  class Meta:
    ordering = ['name']

  def __str__(self):
    return self.updates

class Plans(models.Model):
  name = models.CharField(unique=True, max_length=64)

  def __str__(self):
    return self.name

class Companies(models.Model):
  rut = models.CharField(max_length=32)
  name = models.CharField(max_length=64)
  address = models.CharField(max_length=64)
  district = models.CharField(max_length=64)
  city = models.CharField(max_length=64)
  phone = models.CharField(max_length=64)
  email = models.CharField(max_length=64)
  contact_name = models.CharField(max_length=64)
  logo_image = models.BinaryField(blank=True, null=True)
  logo_mimetype = models.CharField(max_length=64)
  plan = models.ForeignKey(Plans, on_delete=models.PROTECT)

  class Meta:
    ordering = ['name']

  def __str__(self):
    return self.name

class MenusItems(models.Model):
  label = models.CharField(max_length=32)
  parent = models.CharField(max_length=32, null=True)
  title = models.CharField(max_length=32)
  url = models.CharField(max_length=32, null=True)
  menutype = models.IntegerField(default=0) # 0=Menu / 1=HasSubMenu / 2=SubMenu
  position = models.IntegerField(default=0)
  icon = models.CharField(max_length=128, null=True, blank=True)
  icon_active = models.CharField(max_length=128, null=True, blank=True)
  level = models.IntegerField(default=900)

  class Meta:
    ordering = ['position']

  def __str__(self):
    return self.label

  def parents(self):
    return self.__class__.objects.filter().exclude(menutype=2)

  def childs(self):
    return self.__class__.objects.filter(parent=self.label)

class Menus(models.Model):
  name = models.CharField(max_length=32)
  access = models.TextField()
  items = models.ManyToManyField(MenusItems, blank=True)
  company = models.ForeignKey(Companies, on_delete=models.CASCADE, default=1)

  class Meta:
    ordering = ['name']

  def __str__(self):
    return self.name

class Users(models.Model):
  email = models.CharField(unique=True, max_length=64)
  password = models.CharField(max_length=64)
  role = models.ForeignKey(Roles, on_delete=models.PROTECT)
  session_id = models.CharField(max_length=20, blank=True, null=True)
  current_ip = models.GenericIPAddressField(blank=True, null=True)
  last_ip = models.GenericIPAddressField(blank=True, null=True)
  created_at = models.DateTimeField(auto_now_add=True, blank=True)
  updated_at = models.DateTimeField(auto_now_add=True, blank=True)
  rut = models.CharField(max_length=32, blank=True, null=True)
  name = models.CharField(max_length=64, blank=True, null=True)
  address = models.CharField(max_length=64, blank=True, null=True)
  county = models.CharField(max_length=64, blank=True, null=True)
  city = models.CharField(max_length=64, blank=True, null=True)
  phone = models.CharField(max_length=64, blank=True, null=True)
  menu = models.ForeignKey(Menus, on_delete=models.PROTECT)
  view = models.ForeignKey(Views, on_delete=models.PROTECT)
  company = models.ForeignKey(Companies, on_delete=models.PROTECT)

  class Meta:
    ordering = ['name']

  def __str__(self):
    return self.name

class Ruts(models.Model):
  name = models.CharField(max_length=64)
  rut = models.CharField(max_length=32)
  company = models.ForeignKey(Companies, on_delete=models.CASCADE)

  class Meta:
    ordering = ['name']

  def __str__(self):
    return self.name

class Teams(models.Model):
  name = models.CharField(max_length=32)
  company = models.ForeignKey(Companies, on_delete=models.PROTECT)
  user = models.ManyToManyField(Users, blank=True)
#
