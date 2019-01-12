deeplegal.NotificationService = {
	interval : null,
	isInProgress: false,
	frecuency: 1000 * 30, //30 segs
	url : '/updates/',
	loaded: false,
	notificationCounter: 0,
	notifications: null,

	init: function() {
		var t = this;
		//get all the info
		
		//t.ajaxCall(t.startInterval);	

		//demo function
		t.ajaxCallNotification();
	},

	ajaxCallNotification: function() {
		var t = this;
		
		$.ajax({
			url: t.url,
			beforeSend: function() {
				t.isInProgress = true;
			}
		}).done(function(r) {

			if(r.data.length > 0) {
				t.isInProgress = false;
				var notifications = r.data;
				$('#right-sidebar').trigger(deeplegal.Events.NOTIFICATIONS_LOADED, [notifications]);

				//show first notif then loop
				var notification = notifications[t.notificationCounter];
				var id = notification.rit || notification.rol;
				//var desc = notification.historia.tramite_desc || notification.historia.desc_tramite;
				$.Notification.notify('custom','bottom right', id + ' | ' + notification.nombre, notification.estado_proc + '<br>' + notification.etapa);	
				t.notificationCounter++

				t.interval = setInterval(function() {
					t.loopNotifications(notifications);
				},t.frecuency)
			}

		}).fail(function() {
			t.isInProgress = false;
		})
	},

	loopNotifications(notifications) {
		var t = this;
		if(t.notificationCounter < notifications.length) {
			var notification = notifications[t.notificationCounter];
			var id = notification.rit || notification.rol;
			//var desc = notification.historia.tramite_desc || notification.historia.desc_tramite;
			$.Notification.notify('custom','bottom right', id + ' | ' + notification.nombre, notification.estado_proc + '<br>' + notification.etapa);	
			t.notificationCounter++
		} else {
			t.notificationCounter = 0;
			clearInterval(t.interval)
			t.ajaxCallNotification()
		}
		
	},

	ajaxCall: function(cb) {
		var t = this;
		cb = cb || null;
		
		$.ajax({
			url: t.url,
			beforeSend: function() {
				t.isInProgress = true;
			}
		}).done(function(r) {
			t.isInProgress = false;
			var notifications;

			var lastNotificationDate = localStorage.getItem('lastNotificationDate');
			if(!lastNotificationDate) {
				//lastNotificationDate = r.data[0].historia.f_scrapper;
				lastNotificationDate = r.data[0]['@timestamp'];
				localStorage.setItem('lastNotificationDate', lastNotificationDate);
			} 
			
			notifications = t.evalNewNotifications(r.data, lastNotificationDate);
			if(!t.loaded) {
				$('#right-sidebar').trigger(deeplegal.Events.NOTIFICATIONS_LOADED, [notifications]);
				t.loaded = true;			
			} else {
				$('#right-sidebar').trigger(deeplegal.Events.NOTIFICATIONS_UPDATED, [notifications]);
			}

			if(cb) {
				cb();
			}

		}).fail(function() {
			t.isInProgress = false;
		})
	},

	startInterval: function() {
		var t = deeplegal.NotificationService;
		t.interval = setInterval(function() {
			if(!t.isInProgress) {
				t.ajaxCall();
			}
		},t.frecuency);
	},

	evalNewNotifications: function(notifications, date) {
		date = new Date(date);
		var hasNews = false;
		for(var i = 0; i < notifications.length; i++) {
			//var notificationDate = new Date(notifications[i].historia.f_scrapper);
			var notificationDate = new Date(notifications[i]['@timestamp']);
			if(notificationDate > date) {
				notifications[i].isNew = true;
				hasNews = true;
			} else {
				notifications[i].isNew = false;
			}
		}
		//latest should be pos 0
		var lastNotificationDate = notifications[0]['@timestamp'];
		localStorage.setItem('lastNotificationDate', lastNotificationDate);
		
		return notifications;
	}
}

