<cases>
	<div class="row">
	    <div class="col-sm-12">
	      	<div class="row">
		        <div class="cases-header section-header col-sm-12">
		        	<a href="/" class="back-link-item">
		            	<i class="ti-angle-left"></i>
		        	</a>
			        <h1>
			            Causas <span id="forum-name"></span>
			        </h1>
			        <div class="section-actions">
			        	<div class="section-graphs"></div>
			            <div class="section-links">
			            	<a href="/caseselection" class="btn btn-sm btn-primary">Selección de Causas</a>
			            </div>
			  		</div>
				</div>
			</div>
			<div class="row">
			    <div class="cases-body section-body col-sm-12">

			    	<div class="nav-filter-container">
			    		<div class="section-filters">
			              	<ul class="nav nav-tabs">
				                <li class="nav-item">
				                 	<a class="nav-link btn-datatable active show" data-toggle="tab" data-category="laboral" href="#laboral_table">Laboral</a>
				              	</li>
				              	<li class="nav-item">
				                  	<a class="nav-link btn-datatable" data-toggle="tab" data-category="civil" href="#civil_KPI">Civil</a>
				              	</li>
				              	<li class="nav-item">
				                  	<a class="nav-link btn-datatable" data-category="cobranza" data-toggle="tab" href="#cobranza_KPI">Cobranza</a>
				              	</li>
			          		</ul>
			      		</div>
			  		</div>

			     	<div class="tab-content">
			     		<div class="tab-pane active show" id="laboral_table">
			     			<laboral>
			     			</laboral>
			     		</div>
			    	</div>
				</div>
			</div>

		</div>

	</div>
	<script>
		var searchbar = deeplegal.modules.searchbar;
		searchbar.setUp({
			placeholder: 'Buscar casos',
			tags: [{
				value: 'cases', 
				text: 'Casos', 
				context: 'section',
				fixed: true
			},
			{
				value: 'laboral',
				text: 'Laboral',
				context: 'subsection',
				fixed: true
			}],
			search: function(query, tags) {

				//TODO handle tabs switching here when tags are editable

				deeplegal.trigger('searchRequest', {
					query: query,
					tags: tags
				})
			}
		})
	</script>
</cases>