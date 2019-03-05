<searchbar>
    
    <div class="launcher-container disabled" ref="launcherContainer" onclick="{showBar}">
    	<i class="mdi mdi-magnify"></i>
    	<span ref="placeholder">{settings.placeholder}</span>	
    </div>
    <div class="taginput-container" ref="taginputContainer">
    	<input type="text" name="" ref="input" id="top-navbar-search">
    	<button class="close-searchbar" onclick="{hideBar}">X</button>
    </div>
        
        <!-- <span>Buscar Caso, Causas…</span> -->

    <script>
    	/**
 		 * searchbar
 		 * Searches in the given content
    	 * 
    	 */

    	var self = this;
    	var $input = null;
    	this.settings;

    	var defaults = {
    		placeholder: 'Buscar...',
    		disabled: true
    	}

    	this.settings = defaults;

    	/**
    	 * Setup search bar
 		 *
    	 * @param {Object} opts		Configuration object
    	 * opts: {
    	 * 	placeholder: 'Buscar casos',
    	 *	disabled: '' //disables the searchbar,
		 *	tags: [{
         *      value: 1, 
         *      text: 'Casos', 
         *      context: 'section', 
         *      fixed: true //prevents the tag to be removed
         *  }],
		 *	search: function(query, tags) {...}
    	 * }
    	 *
    	 */

    	this.setUp = function(opts) {
    		if(typeof opts.disabled == 'undefined') {
    			opts.disabled = false;
                $(this.refs.launcherContainer).removeClass('disabled');
    		}

    		this.settings = $.extend( {}, defaults, opts );

    		$input = $(this.refs.input);
    		$input.tagsinput({
    			tagClass: function(item) {
				    switch (item.context) {
				        case 'section':
				        	return 'label badge badge-primary ' + (item.fixed ? 'fixed' : '');
				        case 'subsection':
				        	return 'label badge badge-info ' + (item.fixed ? 'fixed' : '');
				    }
				},
				itemValue: 'value',
				itemText: 'text',
    		})

    		this.addTags(this.settings.tags);

    		this.bindEvents($input);

    		this.update();
    	}

    	/**
    	 * set event listeners to the taginput
    	 * 
    	 * @param {Object} $input 	jQuery input object
    	 */

    	this.bindEvents = function($input) {
    		$input.on('beforeItemRemove', function(event) {
				if(event.item.fixed) {
					event.cancel = true;
				}
			});

			$('.bootstrap-tagsinput input[type="text"]').bind('keypress', function(e){
				if(e.keyCode == 13) {
					var query = this.value;
					var items = $input.tagsinput('items');
					self.search(query, items);
				}
			});
    	}

    	/**
    	 * get component data
    	 *
    	 * @return {Object} 	object data {query: '', items: []}
    	 */

    	this.getSearchData = function() {
    		var query = this.root.querySelector('.bootstrap-tagsinput input[type="text"]').value;
    		var items = $input.tagsinput('items');
    		return {
    			query: query,
    			items: items
    		}
    	}

    	/**
    	 * remove existing tags and add new ones
    	 *
    	 * @param {array} tags 	array of objects (tags properties)
    	 */

    	this.updateTags = function(tags) {
    		this.settings.tags = tags;
    		$input.tagsinput('removeAll');
    		this.addTags(tags);
    	}

    	/**
    	 * add tags to the taginput object
    	 *
    	 * @param {array} tags 	array of objects (tags properties)
    	 */

    	this.addTags = function(tags) {
    		for(var i = 0; i < tags.length; i ++) {
    			var tag = this.settings.tags[i];
    			tag.text = capitalize(tag.text);
    			$input.tagsinput('add', tag)
    		}
    	}

    	/**
    	 * search the term using a given callback
    	 *
    	 * @param {string} query 	string to search
    	 * @param {arrat} items		array of tag objects
    	 */

    	this.search = function(query, items) {
    		if(query.length == 0) {
    			return;
    		}
    		
    		this.settings.search(query, items)
    	}

    	/**
    	 * hide the searchbar
    	 */

    	this.hideBar = function() {
    		if (self.settings.disabled) {
    			return;
    		}

    		$(self.refs.taginputContainer).fadeOut('fast');
    		$(self.refs.launcherContainer).fadeIn('fast');
    		$input.tagsinput('input').get(0).value = '';
    		this.trigger('onhide');
    	}

    	/**
    	 * shows the searchbar
    	 */

    	this.showBar = function() {
    		if (self.settings.disabled) {
    			return;
    		}

    		$(self.refs.taginputContainer).fadeIn('fast');
    		$(self.refs.launcherContainer).fadeOut('fast');
    		$input.tagsinput('focus');
    		this.trigger('onshow')
    	}

    	/**
    	 * clears search query
    	 */

    	this.clearQuery = function() {
    		var input = this.root.querySelector('.bootstrap-tagsinput input[type="text"]');
    		input.value = '';
    	}

    	function capitalize(string) {
		    return string.charAt(0).toUpperCase() + string.slice(1);
		}

    	this.on('mount', function() {
    		deeplegal.modules.searchbar = this;
    	})

    </script>
</searchbar>