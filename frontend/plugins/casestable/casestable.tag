<casestable>
	<div class="casestable-wrapper">
		<table ref="table" class="casestable table" cellspacing="0" width="100%" role="grid">
			<thead>
				<tr>
					<th each="{col in config.structure}">{col.header}</th>
				</tr>
			</thead>
			<tbody>
				<tr each="{row in data}" data-item="{JSON.stringify(row)}" onclick="{showOptions}">
					<td each="{col, index in config.structure}">
						{render(config.structure[index].html(row,index,data))}
					</td>
				</tr>
			</tbody>
		</table>

		<div class="row-options-container" if="{selectedItem}">
			<div class="row-options" ref="caseOptions">
				<a class="btn btn-light" href="/cases/{category}/{selectedItem.id}" ref="detailsBtn"> Detalles </a>
				<a class="btn btn-light" href="/cases/{category}/{selectedItem.id}/?notifications"> Notificaciones </a>
				<button onclick="{}" data-toggle="modal" data-target="#modal-litigantes" data-case-id="{selectedItem.id}" data-category="laboral" data-info="litigantes" class="btn btn-light"> Litigantes </button>
				<button onclick="{}" data-toggle="modal" data-target="#modal-historia" data-case-id="{selectedItem.id}" data-category="laboral" data-info="historia" class="btn btn-light"> Historia </button>
				<button onclick="{}" class="btn btn-light text-left" data-case-id="{selectedItem.id}" data-category="laboral"><i class="mdi mdi-file-document"></i> Doc </button>
				<button class="btn btn-danger" data-toggle="modal" data-target="#modal-delete" onclick="{}"> Eliminar </button>
			</div>
		</div>
			
	</div>

	<script>
	var dummy = [{
			id: '12313',
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
			id: '654',
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
		 * casestable
		 * 
		 * Renders list of cases in a table using ajax from a given url 
		 * and loads more content when scrolling bottom.
		 * Recieves an object with its configuration
		 *
		 * @opts.config.category: laboral, civil, etc. used to build options url
		 * @opts.config.url: url to load the data
		 * @opts.config.scroll: url to get more thata when scrolling
		 * @opts.config.structure: table structure. ie:
		 * 		structure: [{
		 *			header: 'Nombre Causa',
		 *			//content: ['name', 'date'],
		 *			html: function(row, index, data) {
		 *				return'<p>'+ row.name +'</p>';
		 *			}
		 *		},
		 *		{
		 *			header: 'RIT',
		 *			//content: ['rit']
		 *			html: function(row, index, data) {
		 *				return'<p class="default light md">' + row.rit + '</p>';
		 *			}
		 *		}]
		 * 
		 */

		var self = this;
		this.config = this.opts.config;
		this.category = this.opts.config.category;
		this.selectedItem = null;
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

		this.showOptions = function() {
			var $currentRow = $(this.root);
			$('.show-options').removeClass('show-options');

			if($currentRow.next().hasClass('row-options')) {
				self.selectedItem = null;
				$('.row-options').remove();
			} else {
				self.selectedItem = JSON.parse(this.root.dataset.item);
				self.update();

				$('.row-options').remove();
				$currentRow.addClass('show-options');
				var $optionsTr = $('<tr>').addClass('row-options');
				var $optionsTd = $('<td>').attr('colspan', self.config.structure.length)
				var $options = $(self.refs.caseOptions);

				$options.appendTo($optionsTd);
				$optionsTd.appendTo($optionsTr);
				$optionsTr.insertAfter($currentRow);	
			}
		}

		this.on('mount', function(argument) {
			
		})

	</script>

</casestable>