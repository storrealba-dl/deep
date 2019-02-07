<scrolltable>
	<p>asdasd</p>
	<table ref="table">
		<thead>
			<tr>
				<th each="{col in config.structure}">{col.header}</th>
			</tr>
		</thead>
		<tbody>
			<tr each="{row in data}">
				<td each="{col, index in config.structure}">
					{render(config.structure[index].html(row,index,data))}
				</td>
			</tr>
		</tbody>
	</table>

	<script>
	var dummy = [{
			name: 'Martinez / Centro de eventos',
			rut: 'M-546-654',
			rit: '18-56-654',
			date: '2018-11-18',
			monitorio: 'Monitorio',
			demanda: 'Demanda',
			status: 'Sin tramitación',
			etapa: 'Sin Archivar',
			tramite: 'Ingreso',
			juzgado: 'Juzgado de letras y garantias de bulnes'
		},
		{
			name: 'Martinez / Centro de eventos',
			rut: 'M-546-654',
			rit: '18-56-654',
			date: '2018-11-18',
			monitorio: 'Monitorio',
			demanda: 'Demanda',
			status: 'Sin tramitación',
			etapa: 'Sin Archivar',
			tramite: 'Ingreso',
			juzgado: 'Juzgado de letras y garantias de bulnes'
		}]
		/**
		 *
		 * scrolltable
		 * 
		 * Renders a table using ajax from a given url 
		 * and loads more content when scrolling bottom.
		 * Recieves an object with its configuration
		 *
		 * @opts.config.url: url to load the data
		 * @opts.config.scroll: url to get more thata when scrolling
		 * 
		 */
		var self = this;
		this.config = this.opts.config;
		this.data = dummy;
		this.headers = null;

		this.update();

		/*
         * loadData
         * Load data to be displayed in the table
         */

		this.loadData = function() {
			 $.ajax({
                method: 'GET',
                url: WS.cases + 'laboral/',
                beforeSend: function() {
                    deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                deeplegal.Util.hideMessage();
                self.data = r.data;
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
		}

		this.render = function(html) {
			this.root.innerHTML = html;
		}

		this.on('mount', function(argument) {
			
		})

	</script>

</scrolltable>