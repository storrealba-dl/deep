<login>
	<div class="wrapper-page auth-page">

        <div class="text-center">
            <a href="/" class="logo-lg">
            	<img src="/static/images/logo-expanded.png">
            </a>
        </div>

        <form class="form-horizontal m-t-20" onsubmit="{submitForm}">
        	
            <div class="form-group row">
                <div class="col-12">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="mdi mdi-account"></i></span>
                        </div>
                        <input class="form-control" type="text" name="user" required="" ref="user" placeholder="Usuario">
                    </div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-12">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="mdi mdi-radar"></i></span>
                        </div>
                        <input class="form-control" type="password" name="password" required="" ref="password" placeholder="Contraseña">
                    </div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-12">
                    <div class="checkbox checkbox-primary">
                        <input id="checkbox-signup" name="remember" type="checkbox" ref="remember">
                        <label for="checkbox-signup">
                            Recuérdame
                        </label>
                    </div>

                </div>
            </div>

            <div class="form-group text-right m-t-20">
                <div class="col-xs-12">
                    <button class="btn btn-primary btn-custom w-md waves-effect waves-light" type="submit" id="submit-btn">Iniciar sesión
                    </button>
                </div>
            </div>

            <div class="form-group row m-t-30">
                <div class="col-sm-12">
                    <a href="pages-recoverpw.html" class="text-muted"><i class="fa fa-lock m-r-5"></i> ¿Olvidaste tu contraseña?</a>
                </div>
            </div>
        </form>
    </div>

    <script>

	    this.submitForm = function(e) {
	    	deeplegal.Util.preventDefault(e);
			var t = this;
			var data = {
				user: this.refs.user.value,
				pass: this.refs.password.value,
				remember: this.refs.remember.checked,
	            csrfmiddlewaretoken: deeplegal.Util.getCsrf()
			}

			$.ajax({
				method: 'POST',
				url: '/auth/login', 
				data: data,
				beforeSend: function() {
					var loadingTemplate = deeplegal.HTMLSnippets.getSnippet('loading');
					deeplegal.Util.showMessage(loadingTemplate, 'alert-info')
				},
				statusCode: {
					403: function() {
						var error403 = deeplegal.HTMLSnippets.getSnippet('error403');
						deeplegal.Util.showMessage(error403, 'alert-warning')
					},
					200: function() {
						location.href = "/";
					}
				}
			})
			.fail(function() {
				deeplegal.Util.showMessage('Hubo un error intentando ingresar', 'alert-danger')
			})
		}	

    </script>
</login>