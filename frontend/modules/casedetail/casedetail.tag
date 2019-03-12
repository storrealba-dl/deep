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
                            <a href="#litigants" data-toggle="tab" aria-expanded="true" class="nav-link">
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

                        <section class="tab-pane fade" id="litigants">
                            <litigants data="{litigants}"></litigants>    
                        </section>

                        <section class="tab-pane fade" id="history">
                            <history data="{history}"></history>    
                        </section>
                        <!-- {% include "cases-full/section-messages.html" %}
                        {% include "cases-full/section-litigantes.html" %}
                        {% include "cases-full/section-notificaciones.html" %}
                        {% include "cases-full/section-historia.html" %} -->
                    </div>

                </div>
                    
            </div>
           
                
        </div>
            
    </div>
    
    <modal id="involved-users-modal" size="lg" title="Usuarios involucrados" ref="modalInvolvedUsers">
    	<yield to="content">
			<involvedusers users="{parent.involvedUsers}" case-id="{parent.opts.caseId}" case-category="{parent.opts.category}" group="involvedUsers"></involvedusers>
		</yield>
    </modal>

    <modal id="involved-teams-modal" size="lg" title="Equipos involucrados" ref="modalInvolvedTeams">
        <yield to="content">
            <involvedusers teams="{parent.involvedTeams}" case-id="{parent.opts.caseId}" case-category="{parent.opts.category}" group="involvedTeams"></involvedusers>
        </yield>
    </modal>
    

    <script>
    /**
     * casedetail
     * Shows all the information about a case
	 *
	 * @param {string} opts.category	Case category (laboral, civil, etc)
	 * @param {string} opts.name 		Case name/title
	 * @param {string} opts.document 	Case document/rut/rit/rol
	 * @param {string} opts.updated		Last update on the case
	 * @param {Object} opts.cards		Information to be displayed on the left cards
	 * @param {string} opts.caseId		Case ID
	 */

	var self = this;
	this.involvedUsers = null;
	this.modalInvolvedUsers = null;

    this.involvedTeams = null;
    this.modalInvolvedTeams = null;

    this.litigants = null;
    this.history = null;

	this.loadInvolvedUsers = function() {
		//XXX UPDATE WS
		deeplegal.Rest.get(WS.users).done(function(r) {
			self.involvedUsers = r.data;
			self.update();
		});
	}

    this.loadInvolvedTeams = function() {
        //XXX UPDATE WS
        deeplegal.Rest.get(WS.teams).done(function(r) {
            self.involvedTeams = r.data;
            self.update();
        }); 
    }

    this.loadLitigants = function() {
        //XXX UPDATE WS
        var caseId = this.opts.caseId;
        deeplegal.Rest.get(WS.litigants, caseId).done(function(r) {
            self.litigants = r;
            self.update();
        })
    }

    this.loadHistory = function() {
        //XXX UPDATE WS
        var caseId = this.opts.caseId;
        deeplegal.Rest.get(WS.history, caseId).done(function(r) {
            self.history = r;
            self.update();
        });
        self.history = {
            "documento": "RIT / RUC: O-307-2019 / 19- 4-0160247-2",
            "etapa": "Ingreso",
            "cuadernos": {
                "8804b01fe5f36aa163269316113bacde": "Principal"
            },
            "historia": [
                {
                    "cuaderno": "Principal",
                    "order": 0,
                    "accion": "Ingreso Causa",
                    "descripcion": "Ingreso Causa",
                    "fecha": "2019-01-14",
                    "idx-sort": -65945708,
                    "instancia": "Escrito",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "65945708"
                },
                {
                    "cuaderno": "Principal",
                    "order": 1,
                    "accion": "Previo a proveer",
                    "descripcion": "Previo a proveer",
                    "fecha": "2019-01-15",
                    "idx-sort": -65945707,
                    "instancia": "Resoluci\u00f3n",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "65945707"
                },
                {
                    "cuaderno": "Principal",
                    "order": 4,
                    "accion": "Cumple lo ordenado",
                    "descripcion": "Cumple lo ordenado",
                    "fecha": "2019-01-18",
                    "idx-sort": -68368217,
                    "instancia": "Escrito",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "68368217"
                },
                {
                    "cuaderno": "Principal",
                    "order": 8,
                    "accion": "Autoriza poder",
                    "descripcion": "Autoriza poder",
                    "fecha": "2019-01-22",
                    "idx-sort": -68368218,
                    "instancia": "Actuaci\u00f3n",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "68368218"
                },
                {
                    "cuaderno": "Principal",
                    "order": 8,
                    "accion": "Da curso y cita aud. preparato",
                    "descripcion": "Da curso y cita aud. preparato",
                    "fecha": "2019-01-22",
                    "idx-sort": -68368216,
                    "instancia": "Resoluci\u00f3n",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "68368216"
                },
                {
                    "cuaderno": "Principal",
                    "order": 11,
                    "accion": "Certif. Notificaci\u00f3n Realizada",
                    "descripcion": "Certif. Notificaci\u00f3n Realizada",
                    "fecha": "2019-01-25",
                    "idx-sort": -68464215,
                    "instancia": "Actuaci\u00f3n",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "68464215"
                },
                {
                    "cuaderno": "Principal",
                    "order": 22,
                    "accion": "Acumulaci\u00f3n y mandato DERCO",
                    "descripcion": "Acumulaci\u00f3n y mandato DERCO",
                    "fecha": "2019-02-05",
                    "idx-sort": -85519438,
                    "instancia": "Escrito",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "85519438"
                },
                {
                    "cuaderno": "Principal",
                    "order": 23,
                    "accion": "Tengase presente",
                    "descripcion": "Tengase presente",
                    "fecha": "2019-02-06",
                    "idx-sort": -85519437,
                    "instancia": "Resoluci\u00f3n",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "85519437"
                },
                {
                    "cuaderno": "Principal",
                    "order": 24,
                    "accion": "Cumple lo ordenado",
                    "descripcion": "Cumple lo ordenado",
                    "fecha": "2019-02-07",
                    "idx-sort": -88138777,
                    "instancia": "Escrito",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "88138777"
                },
                {
                    "cuaderno": "Principal",
                    "order": 28,
                    "accion": "Traslado",
                    "descripcion": "Traslado",
                    "fecha": "2019-02-11",
                    "idx-sort": -88138773,
                    "instancia": "Resoluci\u00f3n",
                    "cuaderno_md5": "8804b01fe5f36aa163269316113bacde",
                    "idx": "88138773"
                }
            ],
            "actualizacion": "2019-01-17",
            "crr_idcausa": 731399,
            "allowed_users": [
                46,
                35,
                96
            ],
            "duracion": 57,
            "materia": "laboral",
            "nombre": "VALDIVIESO/DERCO S.A.",
            "proc": "Ordinario",
            "tribunal": "1\u00ba Juzgado de Letras del Trabajo de Santiago",
            "fechaInicio": "2019-01-14",
            "estado": "Sin archivar"
        }

        self.update();
    }

	this.on('mount', function() {
		this.loadInvolvedUsers();
        this.loadInvolvedTeams();
        this.loadLitigants();
        this.loadHistory();

		this.modalInvolvedUsers = this.refs.modalInvolvedUsers;
        this.modalInvolvedTeams = this.refs.modalInvolvedTeams;
	})

	deeplegal.on('showInvolvedUsers', function(caseData) {
		if(caseData.id == self.opts.caseId) {
			self.modalInvolvedUsers.show();
		}
	})

	deeplegal.on('showTeams', function(caseData) {
		if(caseData.id == self.opts.caseId) {
            self.modalInvolvedTeams.show();
        }
	})

	deeplegal.on('showResources', function(caseData) {
		// TODO
	})

	deeplegal.on('showRelatedCases', function(caseData) {
		// TODO
	})

    </script>
</casedetail>