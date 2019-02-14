<litigants>
	<div class="litigantes-container">
  
    	<div class="item" each="{litigant in opts.data}">
      		<div class="item-title" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="{litigant.part_desc}">
        		{litigant.participante}
      		</div>
      		<div class="item-content">
        		<p class="number">{litigant.rut}</p>
        		<p class="name">{litigant.nombre}</p>
        		<p class="category">{litigant.tipo} / {litigant.cuaderno}</p>
      		</div>
  		</div>
  	</div>
</litigants>