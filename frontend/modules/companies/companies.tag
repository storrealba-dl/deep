<companies>

    <listadmin config="{adminConfig}">
        
        <yield to="modal-edit">
            <div class="form-container">
                <form ref="editForm">
                    
                    <div class="form-row">
                        
                        <div class="form-group col-md-6">
                            <label for="company-name" class="col-form-label">Nombre</label>
                            <input ref="name" name="name" type="text" class="form-control" id="company-name" placeholder="Nombre">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="contact" class="col-form-label">Contacto</label>
                            <input ref="contact_name" name="contact_name" type="text" class="form-control" id="contact" placeholder="Contacto">
                        </div>

                    </div>
                    <div class="form-row">
                        
                        <div class="form-group col-md-6">
                            <label for="email" class="col-form-label">e-mail</label>
                            <input ref="email" name="email" type="email" class="form-control" id="email" placeholder="e-mail">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="phone" class="col-form-label">Telefono</label>
                            <input ref="phone" name="phone" type="text" class="form-control" id="phone" placeholder="Telefono">
                        </div>

                    </div>
                    <div class="form-row">
                        
                        <div class="form-group col-md-6">
                            <label for="address" class="col-form-label">Dirección</label>
                            <input ref="address" name="address" type="text" class="form-control" id="address" placeholder="Dirección">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="city" class="col-form-label">Ciudad</label>
                            <input ref="city" name="city" type="text" class="form-control" id="city" placeholder="Ciudad">
                        </div>

                    </div>
                    <div class="form-row">
                        
                        <div class="form-group col-md-6">
                            <label for="district" class="col-form-label">Comuna</label>
                            <input ref="district" name="district" type="text" class="form-control" id="district" placeholder="Comuna">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="plan" class="col-form-label">Plan</label>
                            <select ref="plan_id" name="plan_id" class="custom-select" id="plan">

                            </select>
                        </div>

                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-4 ">
                            <div id="logo-placeholder">
                                
                            </div>
                        </div>
                        <div class="form-group col-md-8">
                            <label for="company-logo" class="col-form-label">Logo</label>
                            <input name="company_logo" type="file" class="form-control" id="company-logo" name="">
                        </div>                                
                    </div>

                </form>
            </div>
        </yield>

    </listadmin>

    <script>
        this.adminConfig = {
            title: 'Empresas',
            actionButton: 'Agregar Empresas',
            actionIcon: 'mdi mdi-plus-circle',
            datatableUrl: '/companies/',
            datatable: {
                columns: [
                    {
                        title: 'Nombre',
                        width:"160px",
                        targets:0,
                        render:function(t,e,n) {
                            return'<p class="default dark" style="width: 180px ">' + n.name + '</p>';
                        }
                    },
                    {
                        title: 'RUT',
                        targets:1,
                        render:function(t,e,n) {
                            return'<p class="default dark">'+n.rut+'</p>'
                        },
                        visible: false
                    },
                    {
                        title: 'Contacto',
                        targets:2,
                        render:function(t,e,n) {
                            return'<p class="default dark">'+n.contact_name+'</p>'
                        }
                    },
                    {
                        title: 'e-mail',
                        targets:3,
                        render:function(t,e,n) {
                            return'<p class="default dark">' + n.email + '</p>'
                        }
                    },
                    {
                        title: 'Telefono',
                        targets:4,
                        render:function(t,e,n) {
                            return '<p class="default dark">'+n.phone + '</p>'
                        }
                    },
                    {
                        title: 'Dirección',
                        targets:5,
                        render:function(t,e,n) {
                            return '<p class="default dark">'+n.address+'</p>'
                        }
                    },
                    {
                        title: 'Ciudad',
                        targets:6,
                        render:function(t,e,n) {
                            return '<p class="default dark">' + n.city + '</p>'
                        }
                    },
                    {
                        title: 'Comuna',
                        targets:7,
                        render:function(t,e,n) {
                            return '<p class="default dark">' + n.district + '</p>'
                        }
                    },
                    {
                        title: 'Plan',
                        targets:8,
                        render:function(t,e,n) {
                            return '<p class="default dark" data-plan-id="' + n.plan_id + '">' + n.plan_name + '</p>'
                        }
                    },
                    {
                        title: '',
                        orderable:false,
                        targets:9,
                        render:function(t,e,n) {
                            var button = '<div class="btn-group">\
                                <button class="dropdown-toggle waves-effect waves-light btn btn-outline-primary btn-sm" data-toggle="dropdown"><i class="mdi mdi-dots-horizontal"></i></button>\
                                <div class="dropdown-menu" x-placement="bottom-start">\
                                    <a data-company-id="'+ n.id +'" class="dropdown-item" href="#" data-company-info="' + JSON.stringify(n) + '" data-toggle="modal" data-target="#modal-edit">Editar</a>\
                                    <a data-company-id="'+ n.id +'" class="dropdown-item" href="#" onclick="deeplegal.Companies.confirmDeleteCompany(this)" data-toggle="modal" data-target="#modal-delete">Borrar</a>\
                                </div>\
                            </div>';
                            
                            return button
                        }
                    }
                ]
            }
        }

        /**
        * @companyId: if empty will create a new company
        */
        this.saveCompany = function(companyId) {
            var t = this,
                form = this.tags.listadmin.refs.editForm,
                url = companyId ? '/companies/' + companyId  : '/companies/',
                method = companyId ? 'PUT' : 'POST',
                data = new FormData(form);

            data.append('csrfmiddlewaretoken', deeplegal.Util.getCsrf());

            $.ajax({
                method: method,
                url: url,
                data : data,
                cache: false,
                contentType: false,
                processData: false,
                beforeSend: function() {
                    var loading = deeplegal.HTMLSnippets.getSnippet('loading');
                    deeplegal.Util.showMessage(loading, 'alert-info');
                }
            }).done(function(r) {
                deeplegal.Util.hideMessage();

                //success?
                if(status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose(saved, 'alert-success');

                    //TODO: REFRESH COMPANIES t.loadCompanies()
                    this.tags.listadmin.trigger('addedItem');
                    form.reset();
                    $('#logo-placeholder').empty();
                } else {
                    deeplegal.Util.showMessage(r.result, 'alert-danger');    
                }
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        this.deleteCompany = function() {
            //TODO: delete company
        }
    </script>
</companies>