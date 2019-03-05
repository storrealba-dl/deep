<documentlist>
	<ul class="document-list">
		<li each={opts.data}>
			<span>
				<i class="mdi mdi-file-document"></i>
			</span>
			<span>{display}</span>
			<a href="/cases/{path}" target="_blank" class="btn btn-primary">Ver Archivo</a>
		</li>
	</ul>
	<script>
		/**
		 * document-list
		 * @param opts.data		array of objects with 
		 * 						document info to show in a list
		 */
	</script>
</documentlist>