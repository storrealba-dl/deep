<casestable>
	<div class="casestable-wrapper">
		<table ref="table" class="casestable table" cellspacing="0" width="100%" role="grid">
			<thead>
				<tr>
					<th each="{col in config.structure}" data-order="asc" data-sort="{col.sortBy}" onclick="{sort}">{col.header} <i class="mdi mdi-sort"></i></th>
				</tr>
			</thead>
			<tbody>
				<tr each="{row in data}" data-item="{JSON.stringify(row)}" onclick="{toggleOptions}">
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
				<button onclick="{showLitigants}" data-case-id="{selectedItem.id}" data-category="{opts.config.category}" class="btn btn-light"> Litigantes </button>
				<button onclick="{showHistory}" data-case-id="{selectedItem.id}" data-category="{opts.config.category}" class="btn btn-light"> Historia </button>
				<button onclick="{showDocs}" class="btn btn-light text-left" data-case-id="{selectedItem.id}" data-category="{opts.config.category}"><i class="mdi mdi-file-document"></i> Doc </button>
				<button class="btn btn-danger" onclick="{deleteCase}"> Eliminar </button>
			</div>
		</div>
			
	</div>

	<modal ref="infoModal" id="" size="" title="">
		<yield to="content">
			<div id="infoModalContent"></div>
		</yield>
	</modal>

	<script>
		var dummy = [{
			id: 123,
			name: 'ASD asd asasd',
			date: '2012-1-1',
			rit: 123123,
			rut: 130340,
			monitorio: 'Monitorio',
			demanda: 'Demanda',
			status: 'hold',
			tramite: 'largo',
			etapa: 'final',
			juzgado: '1° Juzgado de ñuñoa'
		},
		{
			id: 121233,
			name: '12qwasd asd ',
			date: '2010-1-1',
			rit: 123123,
			rut: 130340,
			monitorio: 'Monitorio',
			demanda: 'Demanda',
			status: 'hold',
			tramite: 'largo',
			etapa: 'final',
			juzgado: '1° Juzgado de ñuñoa'
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
		 *			sortBy: 'date', 
		 *			html: function(row, index, data) {
		 *				return'<p>'+ row.name +'</p>';
		 *			}
		 *		},
		 *		{
		 *			header: 'RIT',
		 *			sortBy: 'rit',
		 *			html: function(row, index, data) {
		 *				return'<p class="default light md">' + row.rit + '</p>';
		 *			}
		 *		}]
		 * 
		 * sortBy: name of property in data object to sort the column
		 * 
		 */

		var self = this;
		this.config = this.opts.config;
		this.category = this.opts.config.category;
		this.selectedItem = null;
		this.data = dummy//[] XXX UPDATE;
		this.headers = null;
		this.isSearching = false;
		this.token = null; //token for scroll}
		this.infoModal = null; //loaded on mount

		this.update();

		/**
         * loadData
         * Load data to be displayed in the table. It concats the results
         * to the data loaded previously stored in this.data
         *
         * @param {string} scroll	Token to get remaining scroll data
         * @param {Object} sorting 	Config to sort the table 	
         */

		this.loadData = function(scroll, sorting) {
			scroll = scroll || false;
			sorting = sorting || {};

			var call;
			deeplegal.Util.showLoading();
			if(!scroll) {
				var id = false;
				call = deeplegal.Rest.get(self.config.url, id, sorting) 
			} else {
				call = deeplegal.Rest.post(self.config.scrollUrl, {scroll: self.token, sorting: sorting}); 	
			}

			call.done(function(r) {
                deeplegal.Util.hideLoading();
                self.data = self.data.concat(r.data);
                self.token = r.token;
                self.update();
            })
		}

		/**
		 * render
		 * add content to columns with the style given in 
		 * @opts.config.structure.html
		 * 
		 * @param {String} html 
		 */

		this.render = function(html) {
			this.root.innerHTML = html;
		}

		/**
		 * toggleOptions
		 * Toggle menu options for each row (litigantes, historia, 
		 * notificaciones, etc).
		 */
		this.toggleOptions = function() {
			var $currentRow = $(this.root);
			$('.show-options').removeClass('show-options');

			if($currentRow.next().hasClass('row-options')) {
				self.hideOptions();
			} else {
				self.selectedItem = JSON.parse(this.root.dataset.item);
				self.update();

				self.showOptions($currentRow);
			}
		}

		/**
		 * hideOptions
		 * Hide menu options for each row (litigantes, historia, 
		 * notificaciones, etc).
		 */

		this.hideOptions = function() {
			self.selectedItem = null;
			$('.row-options').remove();
		}

		/**
		 * showOptions
		 * Show menu options for each row (litigantes, historia, 
		 * notificaciones, etc).
		 * 
		 * @param {Object} $row 	jQuery object of the selected row
		 */

		this.showOptions = function($row) {
			$('.row-options').remove();
			$row.addClass('show-options');
			var $optionsTr = $('<tr>').addClass('row-options');
			var $optionsTd = $('<td>').attr('colspan', self.config.structure.length)
			var $options = $(self.refs.caseOptions);

			$options.appendTo($optionsTd);
			$optionsTd.appendTo($optionsTr);
			$optionsTr.insertAfter($row);	
		}

		/**
		 * sort
		 * sort the table asc or desc based on the table header clicked
		 * (server side)
		 */

		this.sort = function() {
			var sorting = {
				key: this.root.dataset.sort,
				order: this.root.dataset.order
			}
			self.data = [];
			self.loadData(false, sorting);
			updateIconOrder(this.root);

			this.root.dataset.order = this.root.dataset.order == 'asc' ? 'desc' : 'asc';
		}

		/**
		 * showLitigants
		 * loads the litigants and shows them in a modal window.
		 * uses modal and litigants component
		 */

		this.showLitigants = function() {
			deeplegal.Util.showLoading();
			// XXX UPDATE ws and id
			var id = false;
			deeplegal.Rest.get(WS.litigants, id).done(function(r) {
            	deeplegal.Util.hideLoading();
            	
                //setup modal
                self.infoModal.updateOpts({
                	id: 'litigants',
                	size: 'lg',
                	title: 'Litigantes ' + self.selectedItem.name
                })

            	riot.mount('#infoModalContent', 'litigants', {data: r})

            	self.update();
            	self.infoModal.show();
            })
		}

		/**
		 * showHistory
		 * loads case history and shows it in a modal window
		 * uses modal and history component
		 */

		this.showHistory = function() {
			deeplegal.Util.showLoading();
			// XXX UPDATE ws
			var id = false;
			deeplegal.Rest.get(WS.history, id).done(function(r) {
            	deeplegal.Util.hideLoading();
            	
                //setup modal
                self.infoModal.updateOpts({
                	id: 'history',
                	size: 'lg',
                	title: 'Historia ' + self.selectedItem.name
                })
                
                //reverse historia so it shows latests first
				r.historia = r.historia.reverse();
            	riot.mount('#infoModalContent', 'history', {data: r})

            	self.update();
            	self.infoModal.show();
            })
		}

		/**
		 * showDocs
		 * show the files associated to the case. will download / show if 
		 * there's 1 file or open a modal if multiple files.
		 */

		this.showDocs = function() {
			deeplegal.Util.showLoading();
			//XXX UPDATE ws
			var id = false;
			deeplegal.Rest.get(WS.cases + /sarasa/, id).done(function(r) {
            	deeplegal.Util.hideLoading();
            	
                switch(r.length) {
                	case 0:
                		deeplegal.Util.showMessage('El caso no tiene documentos asociados', 'alert-info');
                		break;

                	case 1:
                		// XXX UPDATE ws
                		viewFile(r[0], WS.cases)
                		break;

                	default: 
                		//setup modal
		                self.infoModal.updateOpts({
		                	id: 'documents',
		                	size: 'lg',
		                	title: 'Documentos ' + self.selectedItem.name
		                })
		                
		            	riot.mount('#infoModalContent', 'document-list', {data: r})

		            	self.update();
		            	self.infoModal.show();
                }
            })
		}

		/**
		 * deleteCase
		 * Deletes the case from the user account (uses confirm plugin)
		 */

		this.deleteCase = function() {
			var item = self.selectedItem;
			var deferred = $.Deferred();
			
			deferred.done(function() {
				deeplegal.Util.showLoading();
		        // XXX UPDATE ws
		        deeplegal.Rest.delete(WS.cases, self.selectedItem.id).done(function(r) {
		        	var saved = deeplegal.HTMLSnippets.getSnippet('saved');
		        	deeplegal.Util.showMessageAutoClose(saved);

		        	//remove the item from the data array;
		        	self.data = self.data.filter(deletedItem);
		        	self.hideOptions();
		        	self.update();

		        	function deletedItem(i) {
		        		return i.id != item.id;
	        		}
		        })
			})

			var confirm = deeplegal.plugins.confirm;
			confirm.setOpts({
				promise: deferred,
				message: '¿Desea borrar el caso ' + self.selectedItem.name + '?'
			}).show();
		}

		this.on('mount', function() {
			this.infoModal = this.refs.infoModal;
			this.loadData();
			
			$(window).scroll(function() {
			    if($(window).scrollTop() == $(document).height() - $(window).height()) {
					if(!self.isSearching && self.token) {
						self.loadData(self.token);
					}
			    }
			});
		})

		/**
		 * updateIconOrder
		 * sets the order icon to asc or desc 
		 * @param {Object} TH element
		 */

		function updateIconOrder(header) {
			resetOrder();
			var order = header.dataset.order == 'asc' ? 'ascending' : 'descending';
			var icon = header.querySelector('i.mdi');
			icon.className = 'mdi mdi-sort-'+ order;
		}

		/**
		 * resetOrder
		 * resets order icon in col header
		 */

		function resetOrder() {
		 	var icons = $('i.mdi-sort-ascending, i.mdi-sort-descending', $(self.refs.table));
		 	icons.each(function() {
		 		this.className = 'mdi mdi-sort';
		 	})
		}

		/**
		 * viewFile
		 * open a document in a new window
		 *
		 * @param {Object} file 	Object with file info
		 * @param {string} url 		base url to request the file
		 */

		function viewFile(file, url) {
			window.open(url + '/doc/?path=' + f.path,'_blank');
		}
	</script>

</casestable>