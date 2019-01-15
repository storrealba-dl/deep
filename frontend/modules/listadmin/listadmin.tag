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
                            <button class="btn btn-primary" ref="add-item-btn" id="add-item-btn" data-toggle="modal" data-target="#modal-edit" onclick="deeplegal.Companies.addCompany()"><i class="{settings.actionIcon}"></i> {settings.actionButton}</button>
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

	<div id="modal-edit" refs="modalEdit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-edit.title" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="modal-edit-title">Editar Empresa</h4>
                </div>
                <div class="modal-body">

                    <div class="modal-dynamic-content" ref="modal-dynamic-content">
                    	<yield from="modal-edit"/>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="submit" id="submit-edit" class="btn btn-primary" onclick={ parent.saveCompany }>Guardar</button>
                    <button type="button" class="btn btn-danger waves-effect" data-dismiss="modal">Cancelar</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
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
		* @opts.config.datatableUr: Url for the websersive to render the datatable
		* @opts.config.datatable: datatable config options
		*
		* Events (fired by parent tag)
		* addedItem / editedItem / deletedItem
		* 
		*/

		var defaults = {
			title: 'Admin',
			actionButton: 'Agregar',
			actionIcon: 'mdi mdi-plus-circle',
			datatableUrl: '/',
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
		}

		this.settings = $.extend(true, defaults, this.opts.config)
		
		//adding ajax config
		this.settings.datatable.ajax = {
			url: this.settings.datatableUrl,
			type: 'GET',
			data: {
				csrfmiddlewaretoken: deeplegal.Util.getCsrf();
			}
		}

		var $datatable = $(this.refs.datatable).DataTable(this.settings.datatable);

		riot.observable(this);

		this.on('addedItem', function() {
			$(this.refs.modalEdit).modal('hide');
			$datatable.ajax.reload();
		})

		$(this.modalEdit).on('show.bs.modal', function (e) {
			var data = e.relatedTarget.dataset.companyInfo;
			populateForm(data);
		});

		$(this.modalEdit).on('hidden.bs.modal', function (e) {
			this.refs.formEdit.reset();
		});

		function populateForm(data) {
			for (field in data) {
			  this.refs[field].value = data[field];
			}
		}

	</script>
</listadmin>