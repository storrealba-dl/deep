<optionspanel class="col-md-4">
	<div class="config">
        <div class="card m-b-20 config-container">
            <div class="card-header">
                <h5 class="config-name">
                    {opts.config.name}
                </h5>
                <div class="config-actions-container">
                    <a href="#" data-toggle="modal" data-config-id="{opts.config.id}" data-target="#modal-edit" class="btn-primary btn-edit-config"><i class=" mdi mdi-lead-pencil"></i></a> 
                    <a href="#" data-toggle="modal" data-target="#modal-delete" class="btn-delete-config {opts.config.deleteAllowed ? 'btn-danger' : 'btn-secondary'}"><i class="mdi mdi-delete"></i></a>
                </div>
            </div>
            
            <div class="card-body options-container">
                <p class="card-text">
                    <small class="text-muted">Opciones activas:</small>
                </p>
                
                <span class="badge badge-primary config-option" each="{opts.config.items}">{name}</span>
                
            </div>
        </div>
    </div>
	<script>
		this.on('optionsLoaded', function(options) {
			console.log(options)
		})
	</script>
</optionspanel>