/**
 * namespace for all modules
 */

var deeplegal = {
	
	init: function() {
		if(deeplegal.NotificationService) {
			deeplegal.NotificationService.init();
		}
	}
}
{
	$(document).ready(function() {
		deeplegal.init();
	}) 
}
