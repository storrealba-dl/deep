<ruts>

    <listadmin config="{adminConfig}">
        
        <yield to="modal-edit">
            <div class="form-container">
                <form ref="formEdit">
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label for="rut-number" class="col-form-label">RUT</label>
                            <input type="text" ref="rut" name="rut" class="form-control" id="rut-number" autocomplete="off" placeholder="RUT">
                        </div>
                        <div class="form-group col-md-4">
                            <label for="rut-name" class="col-form-label">Nombre</label>
                            <input type="text" ref="name" name="name" class="form-control" id="rut-name" autocomplete="off" placeholder="Nombre">
                        </div>
                        <div class="form-group col-md-4">
                            <label for="company-list" class="col-form-label">Seleccione empresa</label>
                            <select class="form-control" ref="company_id" id="company-list">
                                
                            </select>
                        </div>
                    </div>
                </form>
            </div>
        </yield>

    </listadmin>

    <script>
        var self = this;
        this.adminConfig = {
            title: 'Seleccion de RUT',
            actionButton: 'Agregar RUT',
            actionIcon: 'mdi mdi-plus-circle',
            datatableUrl: WS.ruts,
            modalsTitle: 'RUT',
            datatable: {
                searching: false,
                language:{
                    paginate:{
                        next:"\u232a",
                        previous:"\u2329"
                    },
                    search: "Buscar"
                },
                columns: [
                {
                    title: 'RUT',
                    targets:0,
                    render:function(t,e,n){
                        return'<p class="default dark">' + n.rut + '</p>';
                    }
                },
                {
                    title: 'Nombre',
                    targets:1,
                    render:function(t,e,n)
                    {
                        return'<p class="default dark">'+n.name+'</p>'
                    }
                },
                {
                    title: 'Empresa',
                    targets:2,
                    render:function(t,e,n){
                        return'<p class="default dark">' + n.company_name + '</p>'
                    }
                },
                {
                    title: '',
                    targets:10,
                    render:function(t,e,n){
                        var button = '\
                        <div class="btn-group">\
                            <button class="dropdown-toggle waves-effect waves-light btn btn-outline-primary btn-sm" data-toggle="dropdown"><i class="mdi mdi-dots-horizontal"></i></button>\
                            <div class="dropdown-menu" x-placement="bottom-start">\
                                <a data-item-id="'+ n.id +'" data-item-name="'+ n.rut +'" data-item-info=\'' + JSON.stringify(n) + '\'class="dropdown-item" href="#" data-toggle="modal" data-target="#modal-edit">Editar</a>\
                                <a data-item-id="'+ n.id +'" data-item-name="'+ n.rut+'" class="dropdown-item" href="#" data-toggle="modal" data-target="#modal-delete">Borrar</a>\
                            </div>\
                        </div>';
                        
                        return button
                    }
                }]
            },
            formValidation: {
                rules: {
                    name: {
                        required: true
                    },
                    rut: {
                        required: true
                    },
                    company_id: {
                       required: true
                    }
                },
                submitHandler: function(form) {
                    var listadmin = self.tags.listadmin;
                    listadmin.trigger('requestAdminSave', listadmin.itemToSave)
                    //self.save();
                },
                invalidHandler: function(event, validator) {
                    deeplegal.Util.showMessageAutoClose('Por favor verifique los datos', 'alert-danger');
                },
                highlight: function(element, errorClass) {
                    return false;
                }
            }
        }

        /**
        * @rutId: if empty will create a new rut
        */

        this.save = function(rutId) {
            var form = this.tags.listadmin.refs.formEdit,
                rutId = rutId || this.tags.listadmin.itemToSave,
                url = rutId ? WS.ruts + rutId + '/'  : WS.ruts,
                method = rutId ? 'PUT' : 'POST',
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

        this.delete = function(rutId) {
            $.ajax({
                method: 'DELETE',
                url: WS.ruts + rutId,
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
                url: WS.ruts, //XXX UPDATE
                data: {
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
                    ref: 'company_id',
                    data: options.companies
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

        this.on('mount', function() {
            var listadmin = this.tags.listadmin;

            this.fetchSelectsData();

            listadmin.on('requestAdminSave', function(itemId) {
                self.save(itemId)
            })

            listadmin.on('requestAdminDelete', function(itemId) {
                self.delete(itemId)
            })

            $(listadmin.refs.modalEdit).on('hidden.bs.modal', function (e) {
                self.resetForm();
            })
        })
    </script>
</ruts>
