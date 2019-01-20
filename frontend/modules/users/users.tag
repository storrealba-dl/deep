<users>

    <listadmin config="{adminConfig}">
        
        <yield to="modal-edit">
            <div class="form-container">
                <form ref="formEdit">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="user-name" class="col-form-label">Nombre</label>
                            <input ref="name" autocomplete="off" type="text" class="form-control" id="user-name" placeholder="Nombre">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="rut" class="col-form-label">RUT</label>
                            <input ref="rut" autocomplete="off" type="text" class="form-control" id="rut" placeholder="RUT">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="email" class="col-form-label">e-mail</label>
                            <input ref="email" autocomplete="off" type="email" class="form-control" id="email" placeholder="e-mail">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="phone" class="col-form-label">Telefono</label>
                            <input ref="phone" autocomplete="off" type="text" class="form-control" id="phone" placeholder="Telefono">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="address" class="col-form-label">Dirección</label>
                            <input ref="address" autocomplete="off" type="text" class="form-control" id="address" placeholder="Dirección">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="city" class="col-form-label">Ciudad</label>
                            <input ref="city" autocomplete="off" type="text" class="form-control" id="city" placeholder="Ciudad">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="district" class="col-form-label">Comuna</label>
                            <input ref="county" autocomplete="off" type="text" class="form-control" id="district" placeholder="Comuna">
                        </div>
                    </div>
                    <div class="form-row"> 
                        <div class="form-group col-md-6">
                            <label for="company" class="col-form-label">Empresa</label>
                            <select ref="company_id" autocomplete="off" type="text" class="form-control" id="company">
                                
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="role" class="col-form-label">Permisos</label>
                            <select ref="role_id" autocomplete="off" type="text" class="form-control" id="role">
                                
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="menu" class="col-form-label">Menu</label>
                            <select ref="menu_id" autocomplete="off" type="text" class="form-control" id="menu">
                                
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="view" class="col-form-label">Vistas</label>
                            <select ref="view_id" autocomplete="off" type="text" class="form-control" id="view">

                            </select>
                        </div>
                        <!-- <div class="form-group col-md-6">
                            <label for="plan" class="col-form-label">Plan</label>
                            <select class="custom-select" id="plan">

                            </select>
                        </div> -->
                        <!-- <div class="form-group col-md-6">
                            <label for="company-logo" class="col-form-label">Logo</label>
                            <input type="file" class="form-control" id="company-logo" name="">
                        </div> -->
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="password" class="col-form-label">Contraseña</label>
                            <input autocomplete="off" type="password" class="form-control" id="password">
                        </div>
                        
                    </div>

                </form>
            </div>
        </yield>

    </listadmin>

    <script>
        var self = this;
        this.adminConfig = {
            title: 'Usuarios',
            actionButton: 'Agregar Usuario',
            actionIcon: 'mdi mdi-plus-circle',
            datatableUrl: WS.users,
            modalsTitle: 'Usuario',
            datatable: {
                searching: true,
                language:{
                    paginate:{
                        next:"\u232a",
                        previous:"\u2329"
                    },
                    search: "Buscar"
                },
                columns: [
                {
                    title: 'Nombre',
                    width:"160px",
                    targets:0,
                    render:function(t,e,n){
                        return'<p class="default dark" style="width: 180px ">' + n.name + '</p>';
                    }
                },
                {
                    title: 'RUT',
                    targets:1,
                    render:function(t,e,n)
                    {
                        return'<p class="default dark">'+n.rut+'</p>'
                    }
                },
                {
                    title: 'e-mail',
                    targets:2,
                    render:function(t,e,n){
                        return'<p class="default dark" title="'+n.email+'">' + n.email + '</p>'
                    }
                },
                {
                    title: 'Telefono',
                    targets:3,
                    render:function(t,e,n){
                        return '<p class="default dark">'+n.phone + '</p>'
                    }
                },
                {
                    title: 'Empresa',
                    targets:7,
                    render:function(t,e,n){
                        return '<p class="default dark" data-company-id="'+n.company_id+'">' + n.company_name + '</p>'
                    }
                },
                {
                    title: 'Perfil',
                    targets:7,
                    render:function(t,e,n)
                    {
                        return'<p  class="default dark" data-role-id="' + n.role_id + '">'+n.role_name+'</p>'
                    }
                },
                {
                    title: 'Vista',
                    targets:8,
                    render:function(t,e,n)
                    {
                        return'<p c class="default dark" data-view-id="' + n.view_id + '">'+n.view_name+'</p>'
                    }
                },
                {
                    title: 'Menu',
                    targets:9,
                    render:function(t,e,n)
                    {
                        return'<p  class="default dark" data-menu-id="' + n.menu_id + '">'+n.menu_name+'</p>'
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
                                <a data-item-id="'+ n.id +'" data-item-name="'+ n.name +'" data-item-info=\'' + JSON.stringify(n) + '\'class="dropdown-item" href="#" data-toggle="modal" data-target="#modal-edit">Editar</a>\
                                <a data-item-id="'+ n.id +'" data-item-name="'+ n.name+'" class="dropdown-item" href="#" data-toggle="modal" data-target="#modal-delete">Borrar</a>\
                            </div>\
                        </div>';
                        
                        return button
                    }
                }]
            },
            formValidation: {
                rules: {
                    name: {
                        required: true,
                        //minlength: 2
                    },
                    rut: {
                        required: true,
                        //minlength: 2
                    },
                    email: {
                       required: true,
                       email: true 
                    },
                    phone: {
                        required: true,
                        digits: true
                    },
                    address: {
                        required: true,
                        //minlength: 2
                    },
                    city: {
                        required: true,
                        //minlength: 2
                    },
                    county: {
                        required: true,
                        //minlength: 2
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
        * @userId: if empty will create a new user
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
</users>
