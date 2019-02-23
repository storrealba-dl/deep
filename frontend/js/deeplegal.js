(function() {
    'use strict';

	/**
	 * namespace for all modules
	 */
	var deeplegal = window.deeplegal = {
		

		opts: {
			path: '/static/',
			modules: [
				'cases',
				'companies',
				'left-sidebar',
				'listadmin',
				'login',
				'menus',
				'optionspanel',
				'right-sidebar',
				'ruts',
				'switchery',
				'top-navbar',
				'users'
			]
		},

		init: function() {
			if(deeplegal.NotificationService) {
				deeplegal.NotificationService.init();
			}

		    window.riot.mount('*');
		    
			
			var fail = function() {
				deeplegal.Util.showMessage('Hubo un error de nuestro lado. Porfavor intente más tarde', 'alert-danger');				
			};

			$.ajaxSetup({
				statusCode: {
					401: fail,
					403: fail,
					404: fail,
					500: fail,
					0: function() {
						deeplegal.Util.showMessage('Su conexión a internet parece caida. Por favor verifiquela.', 'alert-danger');
					}
				}
			})
			$.ajaxPrefilter(function(options){
				if(options.method && options.method !== 'GET') {
					options.header = $.extend(options.headers, {
						'X-XSRF-TOKEN': deeplegal.Util.getCsrf()
					})
				}
			})
			//riot.observable(this);
			//riot.mount('*')
		}
	};

	window.riot.observable(deeplegal);

	$(document).ready(function() {
		deeplegal.init();
	}) 

})();