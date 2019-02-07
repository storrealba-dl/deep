<laboral>
	<scrolltable config="{tableConfig}">
	</scrolltable>

	
	<script>
		this.tableConfig = {
			url: WS.cases + 'laboral/',
			scroll: WS.cases + 'laboral/scroll/',
			structure: [{
				header: 'Nombre Causa',
				//content: ['name', 'date'],
				html: function(row, index, data) {
					return'<p class="default dark" style="width: 180px ">' + row.name + '</p><p class="default light small">' + row.date + '</p>';
				}
			},
			{
				header: 'RIT',
				//content: ['rit']
				html: function(row, index, data) {
					return'<p class="default dark">' + row.rit + '</p>';
				}
			},
			{
				header: 'RUC',
				//content: ['ruc']
				html: function(row, index, data) {
					return'<p class="default dark">' + row.ruc + '</p>';
				}
			},
			{
				header: 'Procedimiento',
				//content: ['monitorio','demanda']
				html: function(row, index, data) {
					return'<p class="default dark">' + row.monitorio + '</p><p class="default light small">' + row.demanda + '</p>';
				}
			},
			{
				header: 'Inicio',
				//content: ['status', 'tramite']
				html: function(row, index, data) {
					return'<p class="default dark">' + row.status + '</p><p class="default light small">' + row.tramite + '</p>';
				}
			},
			{
				header: 'Etapa',
				//content: ['etapa']
				html: function(row, index, data) {
					return'<p class="default dark">' + row.etapa + '</p>';
				}
			},
			{
				header: 'Tribunal',
				//content: ['tribunal']
				html: function(row, index, data) {
					return'<p class="default dark">' + row.juzgado + '</p>';
				}
			}]
		}

		this.on('mount', function (argument) {
			//debugger;
		})
	</script>
</laboral>
