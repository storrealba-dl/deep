(function() {
    'use strict';

    /**
     * REST service
     *
     * @type {Object}
     */
    deeplegal.Rest = {

        /**
         * URL prefix, used for all requests ('/' by default)
         *
         * @type {String}
         */
        _apiRoot: '/r',

        /**
         * Get the API root path
         *
         * @return {String} path
         */
        getApiRoot: function (argument) {
            return this._apiRoot;   
        },


        /**
         * Download one object.
         *
         * @param {string}
         *         type Type of REST object
         * @param {string}
         *         id Primary key ID
         * @return {Deferred} Request promise
         */
        get: function(type, id, queryParams) {
            var url = id ? type + '/' + id + '/' : type + '/';
            return this.call(url, queryParams || {}, 'GET');
        },

        /**
         * POST data
         * @param {string} type,  Type or a part of URL
         * @param {Object} data,  Object to post
         * @param {Object} config, Ajax config
         * @return {Deferred},    Request promise
         */
        post: function(type, data, config) {
            return this.call(type, data, 'POST', config || {});
        },

        /**
         * POST encoded data
         * @param {string} type,  Type or a part of URL
         * @param {Object} data,  Object to post
         * @return {Deferred},    Request promise
         */
        postUrlEncoded: function(type, data) {
            return this.call(type, $.param(data), 'POST', 'application/x-www-form-urlencoded');
        },

        /**
         * POST data
         * @param {string} type,  Type or a part of URL
         * @param {string} id,    Id to save
         * @param {Object} data,  Object to post
         * @param {Object} config, Ajax config
         * @return {Deferred},    Request promise
         */
        put: function(type, id, data, config) {
            return this.call(type + id + '/', data, 'PUT', config || {});
        },

        /**
         * Delete an object
         *
         * @param {string}
         *         type Type of REST object
         * @param {string}
         *         id Object ID to delete
         * @return {Deferred} Request promise
         */
        'delete': function(type, id) {
            return this.call(type + id + '/', {}, 'DELETE');
        },

        /**
         * Internal AJAX request; use callbacks: .done(), .fail(), .always()
         *
         * @param {string}
         *         url URL of the request
         * @param {Object}
         *         data Data to send
         * @param {string}
         *         method REST method name: GET, POST, PATCH, DELETE
         * @param {Object}
         *         ajax extra config
         * @return {Deferred} Request promise $.Deferred()
         */
        call: function(url, data, method, config) {
            var defaults = { 
                contentType: 'application/json',
                processData: true 
            }; 
            var settings = $.extend( {}, defaults, config);

            return $.ajax({
                url: url,
                method: method,
                processData: settings.processData,
                contentType: settings.contentType,
                dataType: 'json',
                data: 'GET' === method || settings.contentType !== 'application/json' ? data : JSON.stringify(data)
            });
        },

        /**
         * Send REST requests one-by-one
         *
         * @param {Array}
         *         callbacks Array of functions that return {Deferred}
         * @param {Deferred}
         *         promise Chain promise, optional
         * @return {Deferred} The last promise in the chain
         */
        queue: function(callbacks, promise) {
            if (!$.isArray(callbacks) || 0 === callbacks.length) {
                return promise;
            }

            callbacks.forEach(function(cb) {
                promise = promise ? promise.then(cb) : cb();
            });

            return promise;
        }

    };

})();
