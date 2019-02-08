<laboral>
	<casestable config="{tableConfig}">
	</casestable>

	
	<script>
		this.tableConfig = {
			category: 'laboral',
			url: WS.cases + 'laboral/',
			scroll: WS.cases + 'laboral/scroll/',
			structure: [{
				header: 'Nombre Causa',
				//content: ['name', 'date'],
				html: function(row, index, data) {
					return'<p class="default dark ellipsis" style="width: 180px ">' + row.name + '</p><p class="default light sm">' + row.date + '</p>';
				}
			},
			{
				header: 'RIT',
				//content: ['rit']
				html: function(row, index, data) {
					return'<p class="default light md">' + row.rit + '</p>';
				}
			},
			{
				header: 'RUT',
				//content: ['ruc']
				html: function(row, index, data) {
					return'<p class="default light md">' + row.rut + '</p>';
				}
			},
			{
				header: 'Procedimiento',
				//content: ['monitorio','demanda']
				html: function(row, index, data) {
					return'<p class="default dark">' + row.monitorio + '</p><p class="default light sm">' + row.demanda + '</p>';
				}
			},
			{
				header: 'Inicio',
				//content: ['status', 'tramite']
				html: function(row, index, data) {
					return'<p class="default dark">' + row.status + '</p><p class="default light sm">' + row.tramite + '</p>';
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
					return'<p class="default light md">' + row.juzgado + '</p>';
				}
			}]
		}

		this.on('mount', function (argument) {
			//debugger;
		})
	</script>
</laboral>
