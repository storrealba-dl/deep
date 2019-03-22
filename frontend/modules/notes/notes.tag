<notes>
	<div class="notes-section">
		<section class="tab-pane fade sub-section sub-section-messages active show" id="messages">
			<div class="sub-section-tools">
				<div class="select">
					<!-- loop options -->
					<select id="select-cuaderno" class="deep-select">
						<option value="principal" selected>Principal</option>
					</select>
				  	<i class="ti-angle-down"></i>
				</div>
				<div class="search-box">
					<input type="text" name="" placeholder="Buscar...">
					<button class="btn-primary"><i class="mdi mdi-magnify"></i></button>
				</div>
			</div>
		</section>
	

{% for h in es.historia %}
		<!-- create component from this -->
  		<article if="{historia}" each="{h in historia}" class="message-container" data-cuaderno="{h.cuaderno_md5}">
    		<div class="main-message">
      			<div class="message-icon light"><i class="mdi mdi-bank"></i></div>
      			<span class="badge badge-primary message-category">Principal</span>
				<p class="message-content">
					{h.instancia} - {h.descripcion} ({h.fecha})
				</p>
      			
      			<button class="history-files btn btn-sm btn-primary" data-history-id="{h.idx}"><i class="mdi mdi-file-document"></i> Doc</button>
    		</div>
    
    		<ol if="{!!h.comments}" class="sub-messages-container">
      			<!-- loop messages -->
      			<li each="{comment in h.comments}" class="sub-message">
        			<div class="sub-message-header">
          				<div class="user-photo initial">{comment.initials}</div>
          				<span class="user-name">{comment.userName}</span>
          				<span class="date">{comment.dateTime}</span>
        			</div>

        			<div class="sub-message-body">
          				<p>{comment.text}</p>
          				<a if="{comment.attachment}" href="{comment.attachment.url}" target="_blank">
            				<span class="attachment"><i class="mdi mdi-attachment"></i> {comment.attachment.fileName}</span>
          				</a>
        			</div>
      			</li>
    		</ol>

    		<div class="leave-message">
      			<form action="/rest/{materia}/{caseId}/{idx}/" class="send-message-form">
        			<div class="user-photo initial">{user.initials}</div>
        
        			<input type="text" name="message" class="input-leave-message" autocomplete="off" placeholder="Escribir comentario">
			        
			        <button type="button" class="btn btn-sm btn-light btn-attachment">
			          <i class="mdi mdi-attachment"></i>
			        </button>
        			
        			<button type="submit" class="btn btn-sm btn-primary btn-send" disabled>
        				<i class="mdi mdi-send"></i>
        			</button>  
        
        			<input type="file" name="file" class="input-file" name="">
        			<input type="submit" name="Send" >
        			
        			<span class="file-name badge badge-primary">
          				<span class="file-reset-btn"><i class="mdi mdi-close-box"></i></span>
          				Archivo: 
          				<span class="file-name-target"></span>
        			</span>
      			</form>
    		</div>
  		</article>
{% endfor %}


	<article if="{!historia} class="message-container" data-cuaderno="437af6ac4183d1207e3764f3f77246a4" style="display: block;">
    	<div class="main-message">
      		<div class="message-icon light">
      			<i class="mdi mdi-bank"></i>
      		</div>
      		<span class="badge badge-primary message-category">Principal</span>
      		<p class="message-content">
        		No existen movimientos en esta causa.
      		</p>
    	</div>
  </article>





	</div>



	

</notes>