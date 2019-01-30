/**
 * namespace for all modules
 */

var deeplegal = {
	tags: null,
	
	init: function() {
		if(deeplegal.NotificationService) {
			deeplegal.NotificationService.init();
		}
		
		riot.observable(this);
		this.tags = riot.mount('*');
	}
}
{
	$(document).ready(function() {
		deeplegal.init();
	}) 
}
