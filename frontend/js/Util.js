deeplegal.Util = {
	getCsrf: function() {
		var cookieValue = null;
		var name = 'csrftoken';
		if(document.cookie &&  document.cookie !== '') {
			var cookies = document.cookie.split(';');
			for(var i=0; i<cookies.length; i++) {
				var cookie = jQuery.trim(cookies[i]);
				if(cookie.substring(0, name.length + 1) === (name + '=')) {
					cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
					break;
				}
			}
		}
		return cookieValue;
	},

	/**
	* elements in form must have ref attr that matches the backend
	*/
	serialize: function(form) {
		var sel = [
			'input[type="text"]',
			'input[type="checkbox"]',
			'input[type="email"]',
			'input[type="file"]',
			'input[type="hidden"]',
			'input[type="number"]',
			'input[type="password"]',
			'input[type="radio"]',
			'input[type="tel"]',
			'input[type="url"]',
			'select',
			'textarea'
		].toString();

		var elements = form.querySelectorAll(sel);
		var data = {}
		for(var i = 0; i < elements.length; i++) {
			var el = elements[i];
			var key = el.getAttribute('ref');
			var value = el.value
			data[key] = value;
		}

		return data;
	},

	preventDefault: function(e) {
		e.preventDefault ? e.preventDefault() : event.returnValue = false;
	},

	chunkArray: function(myArray, chunk_size) {
	    var results = [];
	    
	    while (myArray.length) {
	        results.push(myArray.splice(0, chunk_size));
	    }
	    
	    return results;
	},

	updateProgressBar: function(current, total, $el) {
		var percentage = current * 100 / total;
		$el.width(percentage + '%');
	},

	formatDate: function(datestring, format) {
		switch(format) {
			case 'dd-mm-yyyy':
			case 'dd/mm/yyyy':
			case 'dd-mm-yyyy hh:mm':
			case 'dd/mm/yyyy hh:mm':
				var result = '';
				var date = new Date(datestring);
				var dd = addZero(date.getDate());
				var mm = addZero(date.getMonth() + 1); 
				var yyyy = date.getFullYear();
				var s = format.indexOf('/') > 0 ? '/' : '-';
				
				result = dd + s + mm + s + yyyy;
				
				if(format.indexOf('hh:mm') > 0) {
					var hh = addZero(date.getHours());
					var ms = addZero(date.getMinutes());

					result = result + ' ' + hh + ':' + ms;
				}
				
				return result;
				break;
		}

		function addZero(n){
			if (n < 10) {
			  n = '0' + n;
			}
			return n;
		}
	},

	getMonth: function(datestring) {
		var months = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"];
		var date = new Date(datestring);
		return months[date.getMonth()]
	},

	/**
	* @messageContent : string, htmlstring
	* @alertClass : string (minton alert class)
	*
	*/
	messageTimeout: null,

	showMessage: function(messageContent, alertClass) {
		if(deeplegal.Util.messageTimeout) {
			clearTimeout(deeplegal.Util.messageTimeout)
		}
		var $messageContainer = $('#message-alert-container');
		var $messageTarget = $('#message-alert-target');
		$messageTarget.html(messageContent);
		$messageContainer.removeClass().addClass('alert ' + alertClass);
		$messageContainer.fadeIn('fast');
	},

	hideMessage: function() {
		var $messageContainer = $('#message-alert-container');
		var $messageTarget = $('#message-alert-target');
		$messageContainer.fadeOut('fast', function() {
			$messageTarget.html('');
			$messageContainer.removeClass().addClass('alert ' + 'alert-info');
		});
	},

	showMessageAutoClose: function(messageContent, alertClass, time) {
		time = time || 1500;

		deeplegal.Util.showMessage(messageContent, alertClass);

		deeplegal.Util.messageTimeout = setTimeout(function() {
			deeplegal.Util.hideMessage();
		}, time)

	},

	showLoading: function() {
		var loading = deeplegal.HTMLSnippets.getSnippet('loading');
		deeplegal.Util.showMessage(loading, 'alert-info');
	}
}

/*
  options = {ttl : 300};
*/

deeplegal.Util.Defer = function(options) {
	this.queue = [];

	this.override = true;

	this.defaults = {  
		ttl : 250
	};
	this.options = $.extend({}, this.defaults, options);

	this.clearQueue = function() {
	    var queue = this.queue;
	    var len = queue.length;
	    
	    for(var i = 0; i < len; i++)
	    {
			clearTimeout(queue[i]);
	    }
	    this.queue = [];
  	}    
}

deeplegal.Util.Defer.prototype.timedCall = function(callback) {
	if(this.override) {
		this.clearQueue();
	}
	var ttl = this.options.ttl;
	var timeoutId = setTimeout(callback, ttl);
	this.queue.push(timeoutId);
}
