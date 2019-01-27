/**
 * namespace for all modules
 */

var deeplegal = {
	
	init: function() {
		if(deeplegal.NotificationService) {
			deeplegal.NotificationService.init();
		}
		
		riot.observable(this);
		riot.mount('*')
	}
}
{
	$(document).ready(function() {
		deeplegal.init();
	}) 
}
