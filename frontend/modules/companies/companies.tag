<companies>

    <listadmin config="{adminConfig}">
        
        <yield to="modal-edit">
            <div class="form-container">
                <form ref="formEdit">
                    
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
                            <div ref="logoPlaceholder" id="logo-placeholder">
                                
                            </div>
                        </div>
                        <div class="form-group col-md-8">
                            <label for="company-logo" class="col-form-label">Logo</label>
                            <input ref="logoInput" name="company_logo" type="file" class="form-control" id="company-logo" name="">
                        </div>                                
                    </div>

                </form>
            </div>
        </yield>

    </listadmin>

    <script>
        /**
         * Config to be passed to listadmin component
         */ 

        var self = this;
        this.adminConfig = {
            title: 'Empresas',
            actionButton: 'Agregar Empresa',
            actionIcon: 'mdi mdi-plus-circle',
            datatableUrl: WS.companies,
            modalsTitle: 'Empresa',
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
                                    <a data-item-id="'+ n.id +'" data-item-name="'+ n.name +'" class="dropdown-item" href="#" data-item-info=\'' + JSON.stringify(n) + '\' data-toggle="modal" data-target="#modal-edit">Editar</a>\
                                    <a data-item-id="'+ n.id +'" data-item-name="'+ n.name +'" class="dropdown-item" href="#" data-toggle="modal" data-target="#modal-delete">Borrar</a>\
                                </div>\
                            </div>';
                            
                            return button
                        }
                    }
                ]
            },
            formValidation: {
                rules: {
                    name: {
                        required: true,
                        //minlength: 2
                    },
                    contact_name: {
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
                    district: {
                        required: true,
                        //minlength: 2
                    }
                },
                submitHandler: function(form) {
                    //form.submit();
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
         * save
         * Saves or creates companies 
         * @param {Number} company id. if empty will create a new company
         */

        this.save = function(companyId) {
            var form = this.tags.listadmin.refs.formEdit;
            var companyId = companyId || this.tags.listadmin.itemToSave;
            var data = new FormData(form);

            var config = {
                contentType: false,
                processData: false
            }

            deeplegal.Util.showLoading();
            
            var call = companyId ? deeplegal.Rest.put(WS.companies, companyId, data, config) : deeplegal.Rest.post(WS.companies, data, config)

            call.done(function(r) {
                if(r.status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose(saved, 'alert-success');

                    self.tags.listadmin.trigger('itemAdded');
                    self.resetForm();
                } else {
                    deeplegal.Util.showMessage(r.result, 'alert-danger')
                }
            })
        }

        /**
         * delete
         * Deletes companies 
         * @param {Number} company id
         */

        this.delete = function(companyId) {
            deeplegal.Util.showLoading();

            deeplegal.Rest.delete(WS.companies, companyId).done(function(r) {
                if(r.status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose(saved, 'alert-success');

                    self.tags.listadmin.trigger('itemDeleted');
                }
            })
        }

        /**
         * resetForm
         * Reset form to create/edit companies 
         * passed to listadmin through yelding 
         */

        this.resetForm = function() {
            var listadmin = self.tags.listadmin;
            listadmin.refs.formEdit.reset();
            listadmin.refs.logoPlaceholder.innerHTML = '';
            listadmin.$formEdit.resetForm(); //reset validator
        }

        /**
         * previewLogo
         * Shows the preview for a given image url
         * in the company form 
         * @param {String} image url
         */

        this.previewLogo = function(imgUrl) {
            var listadmin = self.tags.listadmin;
            var logoPlaceholder = listadmin.refs.logoPlaceholder;
            var img = document.createElement('img');
            
            img.setAttribute('src', imgUrl);
            logoPlaceholder.innerHTML = '';
            logoPlaceholder.appendChild(img);
        }

        /**
         * getPlan
         * Loads the plans to be loaded in the select
         * in the company form 
         */

        this.getPlan = function() {
            var id = false;
            deeplegal.Rest.get(WS.plans, id).done(function(r) {
                if(r) {
                    self.renderPlan(r.data);
                }
            })
        }

        /**
         * renderPlan
         * Populates the select with the given options
         * in the company form 
         */

        this.renderPlan = function(planList) {
            var select = self.tags.listadmin.refs.plan_id;
            for(var i = 0; i < planList.length; i++) {
                var option = document.createElement('option');
                option.setAttribute('value', planList[i].id);
                option.innerHTML = planList[i].name;
                select.appendChild(option);
            }
        }


        this.on('mount', function() {
            var listadmin = this.tags.listadmin;

            //get and render plan options
            this.getPlan();
            
            listadmin.on('formPopulated', function(data) {
                var url = WS.pictures + data.id + '/';
                self.previewLogo(url)
            })
            
            listadmin.on('requestAdminSave', function(itemId) {
                self.save(itemId)
            })

            listadmin.on('requestAdminDelete', function(itemId) {
                self.delete(itemId)
            })

            listadmin.refs.logoInput.onchange = function() {
                if(this.files && this.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        var url = e.target.result;
                        self.previewLogo(url)
                    };

                    reader.readAsDataURL(this.files[0]);
                } else {
                    var id = listadmin.itemToSave.id,
                        url = WS.pictures + id + '/';
                    self.previewLogo(url)
                }
            }

            $(listadmin.refs.modalEdit).on('hidden.bs.modal', function (e) {
                self.resetForm();
            })
        })
    </script>
</companies>
