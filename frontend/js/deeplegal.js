(function() {
    'use strict';


    /**
     * Internationalization loaded promise
     * @type {Deferred}
     */
    var i18nInitialized = $.Deferred();

	/**
	 * namespace for all modules
	 */
	var deeplegal = window.deeplegal = {
		

		opts: {
			translationEnabled: false,
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

			if(this.translationEnabled) {
				// i18n is loaded
		        $.when(i18nInitialized).then(function() {
		            // Mount all riot templates
		            window.riot.mount('*');
		        });
			} else {
				window.riot.mount('*');
			}
			
			//riot.observable(this);
			//riot.mount('*')
		}
	};

	window.riot.observable(deeplegal);
	
	// Sometimes this event is fired before the document.ready, so bind it now
    deeplegal.on('i18nInitialized', i18nInitialized.resolve);


	riot.observable(this);

	$(document).ready(function() {
		deeplegal.init();
	}) 

})();