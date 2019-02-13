<laboral>
	<casestable config="{tableConfig}">
	</casestable>

	
	<script>
		this.tableConfig = {
			category: 'laboral',
			url: WS.cases + 'laboral/',
			scrollUrl: WS.cases + 'laboral/scroll/',
			structure: [{
				header: 'Nombre Causa',
				sortBy: 'date', 
				html: function(row, index, data) {
					return'<p class="default dark ellipsis" style="width: 180px ">' + row.name + '</p><p class="default light sm">' + row.date + '</p>';
				}
			},
			{
				header: 'RIT',
				sortBy: 'rit',
				html: function(row, index, data) {
					return'<p class="default light md">' + row.rit + '</p>';
				}
			},
			{
				header: 'RUT',
				sortBy: 'rut',
				html: function(row, index, data) {
					return'<p class="default light md">' + row.rut + '</p>';
				}
			},
			{
				header: 'Procedimiento',
				sortBy: 'monitorio',
				html: function(row, index, data) {
					return'<p class="default dark">' + row.monitorio + '</p><p class="default light sm">' + row.demanda + '</p>';
				}
			},
			{
				header: 'Inicio',
				sortBy: 'status', 
				html: function(row, index, data) {
					return'<p class="default dark">' + row.status + '</p><p class="default light sm">' + row.tramite + '</p>';
				}
			},
			{
				header: 'Etapa',
				sortBy: 'etapa',
				html: function(row, index, data) {
					return'<p class="default dark">' + row.etapa + '</p>';
				}
			},
			{
				header: 'Tribunal',
				sortBy: 'juzgado',
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
