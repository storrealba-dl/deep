(function() {
    'use strict';

    var deeplegal = window.deeplegal;
    var apiRoot = deeplegal.Rest.getApiRoot();
	
	window.WS = {
		login:  		apiRoot + '/login',
		companies: 		apiRoot + '/companies',
		menus: 			apiRoot + '/menus',
		menusItems: 	apiRoot + '/menusitems',
		pictures: 		apiRoot + '/picture',
		plans: 			apiRoot + '/plans',
		users: 			apiRoot + '/users',
		ruts: 			apiRoot + '/ruts',
		menus: 			apiRoot + '/menus',
		teams: 			apiRoot + '/teams',
		cases: 			apiRoot + '/cases'
	}

})();

