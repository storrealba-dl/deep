<listadmin>
	<div class="row m-t-40" id="list-admin">
	    <div class="col-sm-10">
	      	<div class="row">
		        <div class="section-header col-sm-12">
		        	<a href="/" class="back-link-item">
		            	<i class="ti-angle-left"></i>
		        	</a>
			        <h1>
			            {settings.title}
			        </h1>
                    <div class="section-actions">
                        <div class="section-graphs">
                        </div>
                        <div class="section-filters">
                            <button class="btn btn-primary" id="add-item-btn" data-toggle="modal" data-target="#modal-edit"><i class="{settings.actionIcon}"></i> {settings.actionButton}</button>
                        </div>  
                    </div>
                </div>
			</div>
			<div class="row">
				<div class="section-body col-sm-12">
                    <table ref="datatable" id="datatable" data-filter="" data-search="" class="table dt-responsive nowrap" style="table-layout: fixed" cellspacing="0" width="100%">
                    </table>
				</div>
			</div>
		</div>
	</div>

	<div id="modal-edit" ref="modalEdit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-edit.title" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="modal-edit-title">{modalEditAction} {settings.modalsTitle}</h4>
                </div>
                <div class="modal-body">

                    <div class="modal-dynamic-content" ref="modalDynamicContent">
                    	<yield from="modal-edit"/>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="submit" id="submit-edit" class="btn btn-primary" onclick={ handleSave }>Guardar</button>
                    <button type="button" class="btn btn-danger waves-effect" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modal-delete" ref="modalDelete" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-delete.title" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="modal-delete-title">Confirmar</h4>
                </div>
                <div class="modal-body">

                    <div>
                        <p>¿Desea borrar {itemToDelete.name}?</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="submit-delete" class="btn btn-danger" onclick={ handleDelete }>Borrar</button>
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
	
	<script>
		
		/**
		 *
		 * listadmin
		 * 
		 * Renders the view for admin pages using datatable.
		 * Recieves an object with its configuration
		 *
		 * @opts.config.title: Page title
		 * @opts.config.actionButton: Action button text
		 * @opts.config.datatableUr: Url for the websersive to
		 * render the datatable
		 * @opts.config.datatable: datatable config options
		 * @opts.config.formValidation: config object for
		 * form validation 
		 *
		 * Events (fired by parent tag)
		 * addedItem / editedItem / deletedItem
		 * 
		 */

		var self = this;
		
		var defaults = {
			title: 'Admin',
			actionButton: 'Agregar',
			actionIcon: 'mdi mdi-plus-circle',
			datatableUrl: '/',
			modalsTitle: 'Admin',
			datatable: {
				destroy: true,
				processing: true,
				pageLength: 10,
				paging: true,
				ordering: false,
				searching: false,
				info: false,
				filter: false,
				autoWidth: false,
				lengthChange: false,
				fixedColumns: true
			}
		};

		this.itemToDelete = {name: '', id: null};
		this.itemToSave = null;
		this.$formEdit = null;
		this.modalEditAction = 'Editar';
		this.settings = $.extend(true, defaults, this.opts.config)
		
		//adding ajax config
		this.settings.datatable.ajax = {
			url: this.settings.datatableUrl,
			type: 'GET',
			data: {
				csrfmiddlewaretoken: deeplegal.Util.getCsrf()
			}
		}

		//handlers
		this.handleSave = function() {
			if(self.settings.formValidation) {
				$(self.refs.formEdit).submit();	
			} else {
				self.trigger('requestAdminSave', self.itemToSave)
			}
		}

		this.handleDelete = function() {
			self.trigger('requestAdminDelete', self.itemToDelete.id)
		}

		function populateForm(data) {
			for (field in data) {
			  	if(self.refs[field]) {
			  		self.refs[field].value = data[field];
			  	}
			}
			self.trigger('formPopulated', data);
		}

		this.on('mount', function() {
			//start datatable
			this.$datatable = $(this.refs.datatable).DataTable(this.settings.datatable);

			this.on('itemAdded', function() {
				$(self.refs.modalEdit).modal('hide');
				self.itemToSave = null;
				self.$datatable.ajax.reload();
				self.update();
			})

			this.on('itemDeleted', function() {
				$(self.refs.modalDelete).modal('hide');
				self.itemToDelete = {};
				self.$datatable.ajax.reload();
				self.update();
			})

			$(this.refs.modalEdit).on('show.bs.modal', function (e) {
				if(e.relatedTarget.dataset.itemInfo) {	
					self.modalEditAction = 'Editar';
					self.itemToSave = e.relatedTarget.dataset.itemId;
					var data = JSON.parse(e.relatedTarget.dataset.itemInfo);
					populateForm(data);
				} else {
					self.modalEditAction = 'Agregar';
				}
				self.update();
			});

			$(this.refs.modalEdit).on('hidden.bs.modal', function (e) {
				self.itemToSave = null;
				self.$formEdit.resetForm();
				self.update();
			});

			$(this.refs.modalDelete).on('show.bs.modal', function (e) {
				self.itemToDelete.name = e.relatedTarget.dataset.itemName;
				self.itemToDelete.id = e.relatedTarget.dataset.itemId;
				self.update();
			});

			$(this.refs.modalDelete).on('hidden.bs.modal', function (e) {
				self.itemToDelete = {name: '', id: null};
				self.update();
			});

			//form validation
			if(this.settings.formValidation) {
				this.$formEdit = $(this.refs.formEdit).validate(this.settings.formValidation);	
			}

		})


	</script>
</listadmin>