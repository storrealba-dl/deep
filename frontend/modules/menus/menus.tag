<menus>
    <div class="row m-t-40">
        <div class="col-sm-10">
            <div class="row">
                <div class="section-header col-sm-12">
                    <a href="/" class="back-link-item">
                        <i class="ti-angle-left"></i>
                    </a>
                    <h1>
                        Configuraciones de Menú
                    </h1>
                    <div class="section-actions">
                        <div class="section-graphs">
                        </div>
                        <div class="section-filters">
                            <button class="btn btn-primary" id="add-item-btn" data-toggle="modal" data-target="#modal-edit"><i class="mdi mdi-plus-circle"></i> Crear Nueva Configuración</button>
                        </div>  
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="section-body col-sm-12">
                    <h2 if="{menus.length > 0}">Configuraciones existentes:</h2>
                    <div if="{menus.length == 0}">
                        <h2>No hay configuraciones creadas</h2>
                        <p>Haga click en <strong>Crear Nueva Configuración</strong> para empezar.</p>
                    </div>
                    <div class="row">
                        <optionspanel each="{menu in menus}" config="{menu}">
                        </optionspanel>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        var self = this;
        this.menus;
        /**
         * loadMenus 
         * Retrieves menus from db
         */

        this.loadMenus = function() {
            $.ajax({
                method: 'GET',
                url: WS.menus,
                beforeSend: function() {
                    deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                deeplegal.Util.hideMessage();
                self.menus = r.data;
                self.update();
                //self.tags.optionspanel.trigger('optionsLoaded', r.data);
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        this.on('mount', function() {
            this.loadMenus();
        })










        /**
         * save 
         * Saves menu config
         * @param {String} menu config id. If empty will 
         * create a new config
         */

        this.save = function(userId) {
            var form = this.tags.listadmin.refs.formEdit,
                userId = userId || this.tags.listadmin.itemToSave,
                url = userId ? WS.users + userId + '/'  : WS.users,
                method = userId ? 'PUT' : 'POST',
                data = deeplegal.Util.serialize(form);
                
                data.csrfmiddlewaretoken = deeplegal.Util.getCsrf();

            $.ajax({
                method: method,
                url: url,
                data : data,
                beforeSend: function() {
                    var loading = deeplegal.HTMLSnippets.getSnippet('loading');
                    deeplegal.Util.showMessage(loading, 'alert-info');
                }
            }).done(function(r) {
                if(r.status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose(saved, 'alert-success');

                    self.tags.listadmin.trigger('itemAdded');
                    self.resetForm();
                } else {
                    deeplegal.Util.showMessage(r.result, 'alert-danger');    
                }
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        this.delete = function(userId) {
            $.ajax({
                method: 'DELETE',
                url: WS.users + userId,
                data : {
                   csrfmiddlewaretoken: deeplegal.Util.getCsrf()
                },
                beforeSend: function() {
                    var loading = deeplegal.HTMLSnippets.getSnippet('loading');
                    deeplegal.Util.showMessage(loading, 'alert-info');
                }
            }).done(function(r) {
                if(r.status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose(saved, 'alert-success');

                    self.tags.listadmin.trigger('itemDeleted');
                }
            }).fail(function(r) {
                deeplegal.Companies.onFail();
            })
        }

        this.fetchSelectsData = function() {
            $.ajax({
                method: 'GET',
                url: WS.users, //XXX UPDATE
                data: {
                    views: true,
                    menus: true,
                    roles: true,
                    companies: true,
                    csrfmiddlewaretoken: deeplegal.Util.getCsrf()
                }
            }).done(function(r) {
                //self.completeSelects(r);
            }).fail(function(r) {
                deeplegal.Util.showMessage('Hubo un error', 'alert-danger')
            })
        }

        this.completeSelects = function(options) {
            var listadmin = this.tags.listadmin;
            var form = listadmin.refs.formEdit;
        
            loopOptions([{
                    ref:'role_id',
                    data: options.roles
                },
                {
                    ref: 'menu_id',
                    data: options.menus
                }, 
                {
                    ref: 'view_id',
                    data: options.views
                },
                {
                    ref: 'company_id',
                    data: options.views
                }]);

            function loopOptions(array) {
                for(var j = 0; j < array.length; j++) {
                    var option = array[j].data;
                    var select = listadmin.refs[array[j].ref];
                    for (var i = 0; i < option.length; i++) {
                        var opt = option[i];
                        var option = document.createElement('option');
                        option.value(opt.id);
                        option.innerHTML = opt.desc || opt.name;
                        select.appendChild(option);
                    }
                }
            }
        }

        this.resetForm = function() {
            var listadmin = self.tags.listadmin;
            listadmin.refs.formEdit.reset();
            listadmin.$formEdit.resetForm(); //reset validator
        }

        // this.on('mount', function() {
        //     var listadmin = this.tags.listadmin;

        //     this.fetchSelectsData();

        //     listadmin.on('requestAdminSave', function(itemId) {
        //         self.save(itemId)
        //     })

        //     listadmin.on('requestAdminDelete', function(itemId) {
        //         self.delete(itemId)
        //     })

        //     $(listadmin.refs.modalEdit).on('hidden.bs.modal', function (e) {
        //         self.resetForm();
        //     })
        // })
    </script>
</menus>
