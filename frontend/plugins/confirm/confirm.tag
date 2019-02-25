<confirm>
	<modal ref="modal" size="sm" id="confirm" title="{title || 'Confirmar'}">
		<yield to="content">
			{parent.message}
		</yield>
		<yield to="footer">
			<button type="button" onclick="{parent.onOk}" class="btn btn-danger">Borrar</button>
            <button type="button" onclick="{parent.onCancel}" class="btn btn-primary">Cancelar</button>
		</yield>
	</modal>
	<script>
	/**
	 * confirm
	 * opens a confirm dialog (uses modal plugin)
	 *
	 * @param {string} opts.message 	Message/html to show in 
	 * 									the confirm modal
	 * @param {Object} opts.promise 	Promise to resolve / reject 
	 *
	 */

	var self = this;
	this.message = opts.message;
	this.title = opts.title;

	/**
	 * setOpts
	 * set the config for the confirm dialog
	 * @return {Object}		Returns the tag instance
	 */

	this.setOpts = function(opts) {
		self.message = opts.message;
		self.title = opts.title;
		self.promise = opts.promise;
		
		self.update();
		
		return self;
	}

	this.show = function() {
		self.modal.show();
	}

	this.onOk = function() {
	 	self.promise.resolve();
	 	self.modal.hide();
	}

	this.onCancel = function() {
	 	self.promise.reject();
	 	self.modal.hide();
	}

	this.on('mount', function() {
		deeplegal.plugins['confirm'] = this;
		this.modal = this.refs.modal;
	})
	</script>
</confirm>