<menus>
    <div class="row m-t-40">
        <div class="col-sm-10">
            <div class="row">
                <div class="section-header col-sm-12">
                    <a href="/" class="back-link-item">
                        <i class="ti-angle-left"></i>
                    </a>
                    <h1>
                        { _('menus:Configuraciones de Menú') }
                    </h1>
                    <div class="section-actions">
                        <div class="section-graphs">
                        </div>
                        <div class="section-filters">
                            <button class="btn btn-primary" id="add-item-btn" data-toggle="modal" data-target="#modal-add"><i class="mdi mdi-plus-circle"></i> Crear Nueva Configuración</button>
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

                        <optionspanel each="{menu, index in menus}" config="{menu}" index="{index}" not-deletable-tooltip="No se puede eliminar una configuración en uso">
                        </optionspanel>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modal-add" class="modal fade" ref="modalAdd" tabindex="-1" role="dialog" aria-labelledby="modal-add.title" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="modal-edit-title">Crear Nueva Configuración</h4>
                </div>
                <div class="modal-body">
                    
                    <div class="form-container">
                        <form id="add-form">
                            <div class="form-row">
                                <div class="col-sm-12 col-xs-12 checkbox-container">
                                    <label for="config-name">Ingrese el nombre:</label>
                                    <input type="text" class="form-control" name="configName" ref="configName" id="new-config-name">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="submit-create" class="btn btn-primary" onclick="{createMenuConfig}">Crear</button>
                    <button class="btn btn-danger" id="cancel-create" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modal-edit" ref="modalEdit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-edit.title" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="modal-edit-title">Editar Configuración <strong>{currentTitle}</strong></h4>
                </div>
                <div class="modal-body">

                    <h5>Active las opciones que desea agregar</h5>
                    
                    <div class="form-container">
                        <form id="edit-form" ref="editForm">
                            <div class="form-row edit-options-container">
                                
                                <div class="col-sm-4 col-xs-6 checkbox-container"  each="{item in menusItems}">

                                    <switchery color="#3bafda" input-value="{item.id}" label="{item.title}" group="{group}" data-ref="item{item.id}"></switchery>

                                </div>

                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" id="hidden-config-id" value="" name="">
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modal-delete" ref="modalDelete" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-delete.title" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="modal-delete-title">Confirmar</h4>
                </div>
                <div class="modal-body">

                    <div>
                        <p>¿Desea borrar la configuración <strong>{currentTitle}?</strong></p>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" id="delete-config-id" value="">
                    <button type="button" onclick="{delete}" id="submit-delete" class="btn btn-danger">Borrar</button>
                    <button class="btn btn-primary" id="cancel-delete">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        var self = this;
        this.menus;
        this.menusItems;
        this.currentItem;
        this.currentTitle;
        this.group = 'menusItems'; // Labels the switchery to target the event

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
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        /*
         * loadMenusItems
         * Retrieves item list to add on modal edit config
         */

        this.loadMenusItems = function() {
            $.ajax({
                method: 'GET',
                url: WS.menusitems,
                beforeSend: function() {
                    deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                deeplegal.Util.hideMessage();
                self.menusItems = r.data;
                self.update();
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        /**
         * createMenuConfig
         * Creates menu template config 
         * @param {Event} click
         */

        this.createMenuConfig = function(e) {
            deeplegal.Util.preventDefault(e);
            $.ajax({
                method: 'POST',
                url: WS.menus,
                data: {
                    name: self.refs.configName.value,
                    csrfmiddlewaretoken: deeplegal.Util.getCsrf()
                },
                beforeSend: function() {
                    deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                if(r.status == 200) {
                    self.loadMenus();
                    $(self.refs.modalAdd).modal('hide');
                } else {
                    var error = 'Hubo un error.'
                    deeplegal.Util.showMessage(error, 'alert-danger');
                }
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        /**
         * updateCheckboxStatus
         * Set the the switchery checkbox according to config
         * @param {Object} index and id of config to find in this.menu
         */ 
        this.updateCheckboxStatus = function(option) {
            var menu = self.menus[option.index];
            
            //reset all checkbox
            deeplegal.trigger('resetSwitcheryCheckbox') 


            for(var i = 0; i < menu.items.length; i++) {
                var item = menu.items[i];
                var switchery = self.refs['item'+item.id];
                switchery.setSwitchery(true)
            }
        }

        /**
         * save
         * Saves checkbox (switchery) status
         * @param {Object} switchery tag
         */

        this.save = function(switcheryTag) {
            var switcheryData = switcheryTag.getData();
            var data = {
                csrfmiddlewaretoken: deeplegal.Util.getCsrf(),
                itemId: switcheryData.id,
                toggle: switcheryData.checked
            }
            $.ajax({
                method: 'PUT',
                url: WS.menus + this.currentItem + '/',
                data: data,
                beforeSend: function() {
                    //deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                if(r.status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose('saved', 'alert-success');
                    self.loadMenus();
                } else {
                    var error = 'Hubo un error.'
                    deeplegal.Util.showMessage(error, 'alert-danger');
                }
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        /**
         * delete
         * Delete option panel (currentItem)
         */

        this.delete = function() {
             var data = {
                csrfmiddlewaretoken: deeplegal.Util.getCsrf()
            }
            $.ajax({
                method: 'DELETE',
                url: WS.menus + this.currentItem + '/',
                data: data,
                beforeSend: function() {
                    deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                if(r.status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose('saved', 'alert-success');
                    self.loadMenus();
                    $(self.refs.modalDelete).modal('hide');
                } else {
                    var error = 'Hubo un error.'
                    deeplegal.Util.showMessage(error, 'alert-danger');
                }
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        /**
         * clearCurrentItem
         * Resets currentItem and currentTitle
         */

        this.clearCurrentItem = function() {
            self.currentItem = null;
            self.currentTitle = '';
            self.update();
        }

        this.on('mount', function() {
            this.loadMenus();
            this.loadMenusItems();
        })

        // Listener for editing options
        deeplegal.on('editOptionPanel', function(option) {
            self.currentItem = option.id;
            self.currentTitle = self.menus[option.index].name;
            self.updateCheckboxStatus(option);
            self.update();
            $(self.refs.modalEdit).modal('show');
        })

        // Listener for deleting a panel options
        deeplegal.on('deleteOptionPanel', function(option) {
            self.currentItem = option.id;
            self.currentTitle = self.menus[option.index].name;
            self.update();
            $(self.refs.modalDelete).modal('show');
        })

        deeplegal.on('saveSwitcheryStatus', function(tag) {
            if(tag.getData().group == self.group) {
                self.save(tag);    
            }
        })

        $(this.refs.modalEdit).on('hidden.bs.modal', function (e) {
            self.clearCurrentItem();
        });

        $(this.refs.modalDelete).on('hidden.bs.modal', function (e) {
            self.clearCurrentItem();
        });

        $(this.refs.modalAdd).on('hidden.bs.modal', function(e) {
            self.refs.configName.value = '';
        })

    </script>
</menus>
