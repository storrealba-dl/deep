deeplegal.HTMLSnippets = {
	loading: 		'<div class="loading-message"><div class="lds-dual-ring"></div> <span>Cargando</span></div>',
	saving: 		'<div class="loading-message"><div class="lds-dual-ring"></div> <span>Guardando</span></div>',
	sending: 		'<div class="loading-message"><div class="lds-dual-ring"></div> <span>Enviando</span></div>',
	sent: 			'<i class="mdi mdi-check-circle"></i> <span>Enviado</span>',
	saved: 			'<i class="mdi mdi-check-circle"></i> <span>Guardado</span>',
	successSetup:	'<i class="mdi mdi-check-circle"></i> <span>La cuenta ha sido configurada con exito</span>',
	error: 			'<i class="mdi mdi-close-octagon-outline"></i> <span>Hubo un error</span>',
	error404: 		'<i class="mdi mdi-close-octagon-outline"></i> <span>Error 404: No encontrado</span>',
	error403: 		'<i class="mdi mdi-alert"></i> <span>Error 403: Prohibido</span>',
	error500: 		'<i class="mdi mdi-heart-broken"></i> <span>Error 500: Error en el servidor</span>',
	messageSent: 	'<span>Mensaje enviado</span>',

	getSnippet: function(snippetName) {
		return this[snippetName];
	}
}