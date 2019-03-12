<detailcard>

    <section class="card m-b-20 card-body text-xs-center card-summary">
        <h1 class="card-title">
        	{ opts.data.title }
        </h1>
        <dl>
	        <virtual each="{row in opts.data.info}">
                <dt>{row.title}</dt>
                <dd>{row.detail}</dd>
	        </virtual>
	        <virtual if="{opts.data.buttons && opts.data.buttons.indexOf('users') > -1}">
            	<dt>Usuarios involucrados</dt>
                <dd>
                	<button class="btn btn-sm btn-primary" onclick="{showInvolvedUsers}"><i class="mdi mdi-plus-circle"></i> Usuario</button>
                </dd>
            </virtual>

            <virtual if="{opts.data.buttons && opts.data.buttons.indexOf('teams') > -1}">
            	<dt>Equipo de trabajo</dt>
                <dd>
                	<button class="btn btn-sm btn-primary" onclick="{showTeams}"><i class="mdi mdi-plus-circle"></i> Equipo</button>
                </dd>
            </virtual>

            <virtual if="{opts.data.buttons && opts.data.buttons.indexOf('related') > -1}">
                <dt>Causas asociadas</dt>
                <dd>
                    <button class="btn btn-sm btn-primary" onclick="{showResources}"><i class="mdi mdi-plus-circle"></i> Recurso</button><br>
                    <button class="btn btn-sm btn-primary" onclick="{showRelatedCases}"><i class="mdi mdi-plus-circle"></i> Causa</button>
                </dd>	
            </virtual>
        </dl>
        <div class="actions" if="{opts.data.actions && opts.data.actions.indexOf('delete') > -1}">
            <!-- <button class="btn btn-light">Cambiar</button>     -->
            <button onclick="{deleteCase}" class="btn btn-danger">Eliminar</button>
        </div>
    </section>
    
    <script>
    	/**
    	 * detailcard
    	 * shows information about case
    	 *
    	 * @param {Object} opts.data 		data to be displayed in the card
    	 *  data = {
    	 *		title: 'Datos adicionales',
         *      metadata: {
		 *			id: '12313',
		 *			name: 'PEREZ CON LOPEZ',
		 * 			category: 'laboral'
		 * 		},
    	 *		info: [{
		 *			title: 'Libro',
		 *			detail: '10-12121-1B'
		 *	 	},
		 *	 	actions: ['delete'],
		 *	 	buttons: ['users', 'teams']
		 *  }
		 *
		 * @param {string} opts.case 		case name
		 * @param {string} opts.cateogry	case category (laboral, civil, etc)
		 * @param {string} opts.case_id	case id
		 * 
		 */

		/**
		 * deleteCase
		 * Deletes the case from the user account (uses confirm plugin)
		 */

		var tag = this;

    	this.deleteCase = function() {
			var item = tag.opts.data.metadata;

			var deferred = $.Deferred();
			
			deferred.done(function() {
				deeplegal.Util.showLoading();
		        // XXX UPDATE ws
		        deeplegal.Rest.delete(WS.cases, item.id).done(function(r) {
		        	var saved = deeplegal.HTMLSnippets.getSnippet('saved');
		        	deeplegal.Util.showMessage(saved);

		        	setTimeout(function() {
		        		window.location.replace('/cases/?'+item.category);
		        	},3000)
		        })
			})

			var confirm = deeplegal.plugins.confirm;
			confirm.setOpts({
				promise: deferred,
				message: '¿Desea borrar el caso ' + item.name + '?'
			}).show();
    	}

    	/**
    	 * Triggers the event so the component that instantiated shows the data
    	 */
    	this.showInvolvedUsers = function() {
    		deeplegal.trigger('showInvolvedUsers', tag.opts.data.metadata);
    	}

    	this.showTeam = function() {
    		deeplegal.trigger('showTeam', tag.opts.data.metadata);	
    	}

    	this.showResources = function() {
    		deeplegal.trigger('showResources', tag.opts.data.metadata);
    	}

    	this.showRelatedCases = function() {
			deeplegal.trigger('showRelatedCases', tag.opts.data.metadata);
    	}

    </script>
</detailcard>