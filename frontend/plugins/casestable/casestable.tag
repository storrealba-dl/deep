<casestable>
	<div class="casestable-wrapper">
		<table ref="table" class="casestable table" cellspacing="0" width="100%" role="grid">
			<thead>
				<tr>
					<th each="{col in config.structure}" data-order="asc" data-sort="{col.sortBy}" onclick="{sort}">{col.header} <i class="mdi mdi-sort"></i></th>
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
				<button onclick="{}" data-toggle="modal" data-target="#modal-litigantes" data-case-id="{selectedItem.id}" data-category="{opts.config.category}" data-info="litigantes" class="btn btn-light"> Litigantes </button>
				<button onclick="{}" data-toggle="modal" data-target="#modal-historia" data-case-id="{selectedItem.id}" data-category="{opts.config.category}" data-info="historia" class="btn btn-light"> Historia </button>
				<button onclick="{}" class="btn btn-light text-left" data-case-id="{selectedItem.id}" data-category="{opts.config.category}"><i class="mdi mdi-file-document"></i> Doc </button>
				<button class="btn btn-danger" data-toggle="modal" data-target="#modal-delete" onclick="{}"> Eliminar </button>
			</div>
		</div>
			
	</div>

	<script>
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
		this.data = [];
		this.headers = null;
		this.isSearching = false;
		this.token = null; //token for scroll

		this.update();

		/**
         * loadData
         * Load data to be displayed in the table
         */

		this.loadData = function(scroll) {
			scroll = scroll || false;
			var ajax;
			if(scroll) {
				ajax = {
					method: 'POST',
					url: self.config.scrollUrl,
					data: {
						scroll: self.token,
						csrfmiddlewaretoken: deeplegal.Util.getCsrf()
					}
				}
			} else {
				ajax = {
					method: 'GET',
					url: self.config.url
				}
			}

			ajax.beforeSend = function() {
                deeplegal.Util.showLoading();
            }
			
			$.ajax(ajax).done(function(r) {
                deeplegal.Util.hideMessage();
                self.data = self.data.concat(r.data);
                self.token = r.token;
                self.update();
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
		}

		/**
		 * render
		 * add content to columns with the style given in @config.structure.html
		 */

		this.render = function(html) {
			this.root.innerHTML = html;
		}

		/**
		 * showOptions
		 * Show options for each row
		 */
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

		this.sort = function() {
			var key = this.root.dataset.sort;
			var order = this.root.dataset.order;
			self.data.sort(dynamicSort(key, order))
			self.update();
			updateIconOrder(this.root);

			this.root.dataset.order = this.root.dataset.order == 'asc' ? 'desc' : 'asc';
		}

		this.on('mount', function(argument) {
			this.loadData();
			
			$(window).scroll(function() {
			    if($(window).scrollTop() == $(document).height() - $(window).height()) {
					if(!self.isSearching && self.token) {
						self.loadData(true);
					}
			    }
			});
		})


		/**
		 * dynamicSort
		 * used to sort array of objects
		 */

		function dynamicSort(property, order) {
		    var sortOrder = order == 'asc' ? 1 : -1;
		    return function (a,b) {
		        var result = (a[property] < b[property]) ? -1 : (a[property] > b[property]) ? 1 : 0;
		        return result * sortOrder;
		    }
		}

		/**
		 * updateIconOrder
		 * sets the order icon to asc or desc 
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
	</script>

</casestable>