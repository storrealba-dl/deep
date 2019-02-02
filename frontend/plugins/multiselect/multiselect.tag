<multiselect>
	<select multiple="multiple" ref="multiselect">
        <option each="{item in opts.items}" value="{item[key]}">{item[text]}</option>
    </select>
    <script>
    	var self = this;
    	this.key = this.opts.valueKey;
    	this.text = this.opts.textKey;
    	this.$multiselect;

    	/**
    	 * Refreshes the multiselect. use it when updating options after init
    	 */

    	this.refresh = function() {
    		this.$multiselect.multiSelect('refresh');
    	}

    	/**
    	 * Deselects all options
    	 */

    	this.reset = function() {
    		this.$multiselect.multiSelect('deselect_all');
    	}

    	/**
    	 * select option
    	 * @param {String | Number} option value 
    	 */

    	this.select = function(value) {
    		this.$multiselect.multiSelect('select', value);
    	}

    	/**
		 * returns selected options
		 * @return {Array} array of value attribute of selected options
		 */

    	this.getSelectedItems = function() {
    		return $(this.refs.multiselect).val();
    	}
    	
    	this.on('mount', function() {
    		var $select = $(this.refs.multiselect);
	        this.$multiselect = $select.multiSelect({
	            selectableHeader: "<input type='text' class='form-control search-input' autocomplete='off' placeholder='Buscar...'>",
	            selectionHeader: "<input type='text' class='form-control search-input' autocomplete='off' placeholder='Buscar...'>",
	            afterInit: function (ms) {
	                var that = this;
	                var $selectableSearch = that.$selectableUl.prev();
	                var $selectionSearch = that.$selectionUl.prev();
	                var selectableSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selectable:not(.ms-selected)';
	                var selectionSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selection.ms-selected';

	                that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
	                    .on('keydown', function (e) {
	                        if (e.which === 40) {
	                            that.$selectableUl.focus();
	                            return false;
	                        }
	                    });

	                that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
	                    .on('keydown', function (e) {
	                        if (e.which == 40) {
	                            that.$selectionUl.focus();
	                            return false;
	                        }
	                    });
	            },
	            afterSelect: function () {
	                this.qs1.cache();
	                this.qs2.cache();
	            },
	            afterDeselect: function () {
	                this.qs1.cache();
	                this.qs2.cache();
	            }
	        });
    	})

	    	
    </script>
</multiselect>