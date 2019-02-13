from django.conf import settings

DL_APP_NAME = "dev.deeplegal"

DEBUG = True

HTML_MINIFY = False

DL_ES_HOST = "10.142.0.16"
DL_ES_POST = 9876
DL_ES_USER = "dev_deeplegal"
DL_ES_PASS = "dev0099"

DL_ES_INDEX = {
  "laboral": "dev-laboral",
  "civil": "dev-civil",
  "cobranza": "dev-cobranza",
  "multas": "dev-ventanilla",
  "blog": "dev-blog",
  "deepdrive": "dev-deepdrive",
}

DL_GCS_PREFIX = 'dev'
DL_GCS_IDENTITY = settings.BASE_DIR + '/config/.gcs.json'
DL_GCS_BUCKET = {
  "ocr": "deep-ocr",
  "cases": "deep-cases"
}

DL_DB = {
  'ENGINE': 'django.db.backends.postgresql_psycopg2',
  'NAME': 'app_dev',
  'USER': 'dev_deeplegal',
  'PASSWORD': 'dev_dv53!',
  'HOST': '10.142.0.3',
  'PORT': '5432',
}

DL_CASES = {
  "forums": [ "laboral", "civil" ]
}
