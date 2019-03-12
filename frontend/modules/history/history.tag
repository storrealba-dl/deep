<history>
	<div class="col-sm-12 history" if="{opts.data}">
        <!-- header -->
        <div class="d-flex timeline-info">
            <div class="timeline-duration d-flex">
                <div class="d-flex">
                    <span> Duración:&nbsp;</span>
                    <p class="tl-duration">
                        {opts.data.duracion} días
                    </p>
                </div>
                <div class="tl-start-date">
                    {deeplegal.Util.formatDate(opts.data.fechaInicio,'dd-mm-yyyy')}
                </div>
            </div>

            <div class="timeline-status d-flex">
                <div>Estado</div>
                <div class="tl-status"> 
                	{opts.data.estado}
                </div>
            </div>
        </div>

        <div class="timeline tl-article-container" if={opts.data.historia} dir="ltr">
            
            <article class="timeline-item alt tl-end-article">
                <div class="timeline-desk">
                    <div class="panel">
                        <div class="panel-body">
                        	<span class="timeline-icon timeline-icon-end" style=""></span>
                        </div>
                    </div>
                </div>
            </article>

            <!-- left -->

            <virtual each={item, i in opts.data.historia}>

            	<article class="timeline-item {i % 2 == 0 ? 'tl-left-article alt' : 'tl-right-article'}">
	                <div class="timeline-desk">
	                    <div class="panel" style="min-height: 110px">
	                        <div class="panel-body">
	                            <span class="arrow-alt"></span>
	                            <span class="timeline-icon" title="{new Date(item.fecha).getFullYear()}">
	                                <span class="timeline-month tl-month">
	                                	{deeplegal.Util.getMonth(item.fecha)}
	                                </span><br>
	                                <span class="timeline-day tl-day">
	                                {new Date(item.fecha).getDate()}
	                                </span>
	                            </span>
	                            <div class="{i % 2 == 0 ? 'timeline-left-panel' : 'timeline-right-panel'}">
	                                <div class="d-flex direction">
	                                    <p class="timeline-button tl-action">
	                                    	{item.accion}
	                                    </p>
	                                    <p class="timeline-up-text-style text-center tl-action-instance">
	                                    	{item.instancia}
	                                    </p>
	                                </div>
	                                <div class="timeline-text-area under-style" style="{!item.document ? 'padding-bottom: 30px' : ''}">
	                                    <a if={item.documento} href="#" class="btn btn-light btn-sm tl-doc">
	                                        <img src="/static/images/pdf-icon.png" width="25" height="27">

	                                        {item.documento.nombre}
	                                    </a>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                 </div>
	            </article>

	            <article if={ !opts.data.historia[i+1] || new Date(item.fecha).getFullYear() != new Date(opts.data.historia[i+1].fecha).getFullYear() } class="timeline-item alt tl-start-article">
	                <div class="timeline-desk">
	                    <div class="panel">
	                        <div class="panel-body">
	                            <span class="timeline-icon timeline-icon-start tl-start-year">{new Date(item.fecha).getFullYear()}</span>
	                        </div>
	                    </div>
	                </div>
	            </article>  
            </virtual>

        </div>
    </div>
    <script>
    /**
     * history
     * @param {Object} opts.data 	Object with the history info. historia should be reversed beforehand
  	 */

  	var self = this;
 	// used to store the history year in order to show
 	// it when it changes. Uses first one as default
	this.prevYear = this.opts.data && this.opts.data.historia ? new Date(this.opts.data.historia[0].fecha).getFullYear() : null;

	this.setPrevYear = function(year) {
		console.log('prev year: ' + self.prevYear)
		self.prevYear = year;
		console.log('updated year to: ' + self.prevYear)
	}
    </script>
</history>