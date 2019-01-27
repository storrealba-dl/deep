<optionspanel class="col-md-4">
	<div class="config">
        <div class="card m-b-20 config-container">
            <div class="card-header">
                <h5 class="config-name">
                    {opts.config.name}
                </h5>
                <div class="config-actions-container">
                    <a href="#" data-config-id="{opts.config.id}" data-index="{index}" class="btn-primary btn-edit-config" onclick="{onEditClick}"><i class=" mdi mdi-lead-pencil"></i></a> 
                    <a href="#" data-config-id="{opts.config.id}" data-index="{index}" class="btn-delete-config {opts.config.deleteAllowed ? 'btn-danger' : 'btn-secondary'}" data-toggle="{!opts.config.deleteAllowed ? 'tooltip' : false}" data-original-title="{!opts.config.deleteAllowed ? opts.notDeletableTooltip : false}" onclick="{opts.config.deleteAllowed ? onDeleteClick : false}"><i class="mdi mdi-delete"></i></a>
                </div>
            </div>
            
            <div class="card-body options-container">
                <p class="card-text">
                    <small class="text-muted">Opciones activas:</small>
                </p>
                
                <span class="badge badge-primary config-option" each="{opts.config.items}" ref="activeItem" data-id="{id}" data-name="{name}">{name}</span>
                
            </div>
        </div>
    </div>
	<script>
		/**
		 * onEditClick
		 * Handler for editing the option
		 * @param {Event} click
		 */
		this.onEditClick = function (e) {
			deeplegal.Util.preventDefault(e);
			var option = {
				index: e.currentTarget.dataset.index,
				id: e.currentTarget.dataset.configId
			}

			deeplegal.trigger('editOptionPanel', option);
		}

		/**
		 * onDeleteClick
		 * Handler for deleting the option panel
		 * @param {Event} click
		 */
		this.onDeleteClick = function (e) {
			deeplegal.Util.preventDefault(e);
			var option = {
				index: e.currentTarget.dataset.index,
				id: e.currentTarget.dataset.configId
			}

			deeplegal.trigger('deleteOptionPanel', option);
		}


		/**
		 * getActiveItems
		 * Get items in option panel
		 * @return {Array} array of objects with id and name of item
		 */
		this.getActiveItems = function() {
			var items = this.refs.activeItem;
			var array = [];
			for (var i = 0; i < items.length; i++ ) {
				var item = items[i];
				array.push({
					id: item.dataset.id,
					name: item.dataset.name
				})
			}

			return array;
		}

		this.on('mount', function() {
			$('[data-toggle="tooltip"]', $(this.root)).tooltip()
		})
	</script>
</optionspanel>