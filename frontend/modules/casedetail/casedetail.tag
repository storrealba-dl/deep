<casedetail>
	<div class="row m-t-40">
        <div class="col-sm-12">
            <div class="row">
                <div class="cases-full-header section-header">
                    <a href="/cases?{opts.category}" class="back-link-item">
                        <i class="ti-angle-left"></i>
                    </a>
                    <div>
                        <h1>
                            {opts.name}
                        </h1>
                        <span>{opts.document}</span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-4">
                    
                    <div class="case-full-info">
                    	
                    	<detailcard each="{card in opts.cards}" data="{card}"></detailcard>

                    </div>
                          
                </div>

                <div class="col-sm-8 section-content">
                    <!-- tabs -->
                    <ul class="nav nav-tabs">
                        <li class="nav-item mobile-hidden">
                            <a href="#messages" data-toggle="tab" aria-expanded="false" class="nav-link {opts.tabselect == "messages" ? 'active show' : ''}">
                                <span class="tab-icon">
                                    <i class="mdi mdi-message-outline"></i>
                                </span>
                                Notas
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#litigantes" data-toggle="tab" aria-expanded="true" class="nav-link">
                                <span class="tab-icon">
                                    <i class="mdi mdi-account-multiple-outline"></i>
                                </span>
                                Litigantes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#notifications" data-toggle="tab" aria-expanded="false" class="nav-link {opts.tabselect == "notifications" ? 'active show': ''}">
                                <span class="tab-icon">
                                    <i class="mdi mdi-bell-outline"></i>
                                </span>
                                Notificaciones
                            </a>
                        </li>
                        <li class="nav-item mobile-hidden">
                            <a href="#history" data-toggle="tab" aria-expanded="false" class="nav-link">
                                <span class="tab-icon">
                                    <i class="mdi mdi-history"></i>
                                </span>
                                Historia
                            </a>
                        </li>
                    </ul>
                    <!-- tab content -->
                    <div class="tab-content">
                        <div class="tabs-shared-header">
                            <div class="tabs-shared-description">Actualizado {opts.updated}</div>
                            <div class="tabs-shared-actions">
                                <ul>
                                    <li><a href="#"><i class="ti-reload"></i></a></li>
                                    <li><a href="#"><i class="ti-plus"></i></a></li>
                                    <li><a href="#"><i class="ti-file"></i></a></li>
                                    <li><a href="#"><i class="ti-angle-down"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <!-- {% include "cases-full/section-messages.html" %}
                        {% include "cases-full/section-litigantes.html" %}
                        {% include "cases-full/section-notificaciones.html" %}
                        {% include "cases-full/section-historia.html" %} -->
                    </div>

                </div>
                    
            </div>
           
                
        </div>
            
    </div>
    <script>

    </script>
</casedetail>