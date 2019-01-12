DeepLegal front-end is built into small riot apps. Each section behaves as a single page app using riot.js.

Since the backend is built using django and it has its own templating engine, we use its features to build the front-end. 

Each section will have its own django template saved in **/frontend/django-templates** and most likely all of them will inherit the structure and common resources from the base template (/frontend/django-templates/base/base.html).

Any global resource (ie: a new library, global css, etc) should be added in there.

Custom resources will be added in each django-template using the django templating features as follows:

{% block section_css %}
<link rel="stylesheet" type="text/css" href="/frontend/modules/my-module/my-module.css">
{% endblock section_css %}

{% block section_scripts %}
<script type="text/javascript" src="/frontend/modules/my-module/my-module.js"></script>
{% endblock section_scripts %}

*Notice: the module is included using the .js extension instead of .tag, as well as .css instead of less, since it is compiled during the build process.

Those django templates will serve as index or entry file for each riot app. The modules used in them are saved in **/frontend/modules** along with its .less file.

Libraries and 3rd party resources are stored in **/frontend/lib**

Global scripts and configs are stored in **/frontend/js**

Global and common styles are stored in **/frontend/styles**


To build the frontend:

Run npm install inside the /frontend folder.

Run gulp buildTest to work locally 

Run gulp buildProd to build for stg / prod

Target folders are /static and /templates. They are cleaned on each build.

For more info check the **gulpfile.js**