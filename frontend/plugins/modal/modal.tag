<modal>
	<div id="{id}" class="modal fade" tabindex="-1" ref="modal" role="dialog" aria-labelledby="{id}.title" aria-hidden="true" style="display: none;">
	    <div class="modal-dialog modal-{size}">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title">{title}</h4>
	            </div>
	            <div class="modal-body">

	           		<yield from="content"/>
	                
	            </div>
	            <div class="modal-footer">
	                <yield from="footer"/>
	            </div>
	        </div>
	    </div>
	</div>
	
	<script>
		/**
		 * modal
		 * component to show content in a modal window
		 *
		 * @param opts.id		id for the html element
		 * @param opts.size		modal window size
		 * @param opts.title 	modal title
		 * @param opts.onOpen 	callback for the show event
		 * @param opts.onClose 	callback for the hidden event
		 * @yield content 		modal content
		 * @yield footer 		modal footer
		 *
		 */

		var self = this;
		this.id = this.opts.id;
		this.size = this.opts.size;
		this.title = this.opts.title;

		var self = this;
		this.on('mount', function() {
		 	this.modal = this.refs.modal;	

		 	$(this.modal).on('hidden.bs.modal', function() {
			 	if(self.opts.onClose) {
			 		self.opts.onClose();	
			 	}
			 })

			 $(this.modal).on('show.bs.modal', function() {
			 	if(self.opts.onOpen) {
			 		self.opts.onOpen();	
			 	}
			 })
		})
		 
		this.show = function() {
		 	$(this.modal).modal('show');
		}

		this.hide = function() {
		 	$(this.modal).modal('hide');
		}

		this.updateOpts = function(opts) {
			self.id = opts.id;
			self.size = opts.size;
			self.title = opts.title;
			self.update();
		}
	
	</script>
</modal>