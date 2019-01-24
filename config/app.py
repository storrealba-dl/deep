from django.conf import settings

DL_APP_NAME = "app.deeplegal"

DEBUG = False

HTML_MINIFY = True

DL_ES_HOST = "10.142.0.16"
DL_ES_POST = 9876
DL_ES_USER = "app_deeplegal"
DL_ES_PASS = "qqHDW7xLJJ%8Hm4"

DL_ES_INDEX = {
  "laboral": "index-laboral",
  "civil": "index-civil",
  "cobranza": "index-cobranza",
  "multas": "index-ventanilla",
  "blog": "app-blog",
  "deepdrive": "app-deepdrive",
}

DL_GCS_PREFIX = 'app'
DL_GCS_IDENTITY = settings.BASE_DIR + '/config/.gcs.json'
DL_GCS_BUCKET = {
  "ocr": "deep-ocr",
  "cases": "deep-cases"
}

DL_DB = {
  'ENGINE': 'django.db.backends.postgresql_psycopg2',
  'NAME': 'app_prod',
  'USER': 'app_deeplegal',
  'PASSWORD': 'deep_dv53!',
  'HOST': '10.142.0.3',
  'PORT': '5432',
}
