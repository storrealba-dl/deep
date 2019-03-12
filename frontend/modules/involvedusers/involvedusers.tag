<involvedusers>
	<div class="involved-users">
	    <div class="form-container">
	        <div class="form-row">
	            <div class="form-group col-md-4">
	                <label class="control-label m-r-5">Filtrar por</label>
	                <select id="filter-allowed" ref="filterAllowed" class="form-control input-sm">
	                    <option value="">Todos</option>
	                    <option value="Activo">Activo</option>
	                </select>
	            </div>

	            <div class="col-md-4 form-group">
	                <label for="users-searchbox" class="control-label m-r-5">Buscar</label>
	                <input id="users-searchbox" ref="usersSearchbox" type="text" class="form-control" >
	            </div>
	        </div>
	    </div>
	    

	    <table id="users-table" ref="usersTable" class="table table-striped table-bordered toggle-circle m-b-0 default" data-page-size="10">
	        <thead>
	            <tr>
	                <th data-sort-ignore="true">Agregar</th>
	                <th data-toggle="true">E-mail</th>
	                <th data-toggle="true">Empresa Usuario</th>
	                <th data-toggle="true">Nombre</th>
	                <th data-toggle="true">Estado</th>
	            </tr>
	        </thead>
	        <tbody id="users-row-container">
	            <tr style="" class="footable-even" each="{user in opts.users}">
	            	<td>
	            		<switchery color="#3bafda" input-value="{user.id}" group="{group}" checked="{user.added}" data-ref="user-{user.id}"></switchery>
	            	</td>
	            	<td>{user.email}</td>
	            	<td>{user.company}</td>
	            	<td>{user.name}</td>
	            	<td><span class="badge badge-primary">{user.status}</span></td>
	            </tr>
	        </tbody>
	    </table>
	</div>
	<script>
		/**
		 * involvedusers
		 * Shows all the users for a case and add / remove them from it.
		 *
		 * @param {Object} opts.users 			Array of users
		 * @param {string} opts.caseId  		Case ID
		 * @param {string} opts.caseCategory	Case category
		 */

		var self = this;
		this.group = 'involvedUsers'; // Labels the switchery to target the event
		
		/**
		 * saveInvolvedUsers
		 * Saves the status of a given user based on the switchery selection (off/on)
		 *
		 * @param {Object} user 	User data
		 */

		this.saveInvolvedUsers = function(user) {
			//XXX UPDATE WS
			deeplegal.Rest.put(WS.users, this.opts.caseId, user).done(function(r) {
                if(r.status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose('saved', 'alert-success');
                } else {
                    var error = 'Hubo un error.'
                    deeplegal.Util.showMessage(error, 'alert-danger');
                }
            })
		}

		this.setUpTable = function() {
			var $table = $(this.refs.usersTable);
			var $select = $(this.refs.filterAllowed);
			var $search = $(this.refs.usersSearchbox);

		    $table.footable().on('footable_filtering', function (e) {
		        var selected = $select.find(':selected').val();
		        e.filter += (e.filter && e.filter.length > 0) ? ' ' + selected : selected;
		        e.clear = !e.filter;
		    });

		    // Filter status
		    $select.change(function (e) {
		        e.preventDefault();
		        $table.trigger('footable_filter', {filter: $(this).val()});
		    });

		    // Search input
		    $search.on('input', function (e) {
		        e.preventDefault();
		        console.log('searching')
		        $table.trigger('footable_filter', {filter: $(this).val()});
		    });
		}

		this.on('mount', function() {
			this.setUpTable();
		})

		deeplegal.on('saveSwitcheryStatus', function(switchery) {
            if(switchery.getData().group == self.group) {
                self.saveInvolvedUsers(switchery.getData());    
            }
        })
	</script>

</involvedusers>