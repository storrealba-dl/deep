<teams>
    <div class="row m-t-40">
        <div class="col-sm-10">
            <div class="row">
                <div class="section-header col-sm-12">
                    <a href="/" class="back-link-item">
                        <i class="ti-angle-left"></i>
                    </a>
                    <h1>
                        Equipos de Trabajo
                    </h1>
                    <div class="section-actions">
                        <div class="section-graphs">
                        </div>
                        <div class="section-filters">
                            <button class="btn btn-primary" id="add-item-btn" data-toggle="modal" data-target="#modal-add"><i class="mdi mdi-plus-circle"></i> Crear Nuevo Equipo</button>
                        </div>  
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="section-body col-sm-12">
                    <h2 if="{teams.length > 0}">Configuraciones existentes:</h2>
                    <div if="{teams.length == 0}">
                        <h2>No hay equipos creados</h2>
                        <p>Haga click en <strong>Crear Nuevo Equipo</strong> para empezar.</p>
                    </div>
                    <div class="row">

                        <optionspanel each="{team, index in teams}" config="{team}" index="{index}" items="{team.members}" not-deletable-tooltip="No se puede eliminar un equipo en uso">
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
                                    <input type="text" class="form-control" name="teamName" ref="teamName" id="new-config-name">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="submit-create" class="btn btn-primary" onclick="{createTeam}">Crear</button>
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
                    <h4 class="modal-title" id="modal-edit-title">Editar Equipo de Trabajo <strong>{currentTitle}</h4>
                </div>
                <div class="modal-body">

                    <h5>Seleccione los usuarios que desea incluir</h5>
                    
                    <div class="form-container">
                        <form id="edit-form">
                            <div class="form-row edit-options-container">
                                
                                <div data-is="multiselect" ref="usersSelect" items="{users}" value-key="id" text-key="name">
                                </div>

                                <!-- <select multiple="multiple" ref="selectUsers" id="users-select">
                                    <option each="{user in users}" value="{user.id}">{user.name}</option>
                                </select> -->

                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="submit-save" class="btn btn-primary" onclick="{save};">Guardar</button>
                    <button class="btn btn-danger" id="cancel-save" data-dismiss="modal">Cancelar</button>
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
                        <p>¿Desea borrar el equipo <strong>{currentTitle}</strong>?</p>
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
        this.teams;
        this.users;
        this.currentItem;
        this.currentTitle;
        this.group = 'menusItems'; // Labels the switchery to target the event

        /**
         * loadTeams 
         * Retrieves teams from db
         */

        this.loadTeams = function() {
            $.ajax({
                method: 'GET',
                url: WS.teams,
                beforeSend: function() {
                    deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                deeplegal.Util.hideMessage();
                self.teams = r.data;
                self.update();
            }).fail(function(r) {
                //XXX test
                self.teams = [{"name": "equipo 1", "id": 1, "deleteAllowed": false, "members": [{"id": 62, "name": "aaronn"}, {"id": 46, "name": "CARLOS SOLA"}, {"id": 35, "name": "Sebastian Torrealba"}]}, {"name": "equipo nuevo", "id": 12, "deleteAllowed": true, "members": []}, {"name": "grupo123123123", "id": 16, "deleteAllowed": true, "members": []}, {"name": "grupito", "id": 17, "deleteAllowed": true, "members": []}, {"name": "grupito1111", "id": 18, "deleteAllowed": true, "members": []}];
                self.update();
                //XXX end test

                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        /*
         * loadUsers
         * Retrieves item list to add on modal edit config
         */

        this.loadUsers = function() {
            $.ajax({
                method: 'GET',
                url: WS.users,
                beforeSend: function() {
                    deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                deeplegal.Util.hideMessage();
                self.users = r.data;
                self.update();
                self.refs.usersSelect.refresh();
            }).fail(function(r) {
                var error = 'Hubo un error.'
                deeplegal.Util.showMessage(error, 'alert-danger');
            })
        }

        /**
         * createTeams
         * Creates team of users
         * @param {Event} click
         */

        this.createTeam = function(e) {
            deeplegal.Util.preventDefault(e);
            $.ajax({
                method: 'POST',
                url: WS.teams,
                data: {
                    name: self.refs.teamName.value,
                    csrfmiddlewaretoken: deeplegal.Util.getCsrf()
                },
                beforeSend: function() {
                    deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                if(r.status == 200) {
                    self.loadTeams();
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
         * updateMultiselect
         * Set the mutliselect according to config
         * @param {Object} {index: 1, id: 10} index and id 
         * of config to find in this.menu
         */ 
        this.updateMultiselect = function(option) {
            var team = self.teams[option.index];
            
            var usersSelect = this.refs.usersSelect;
            usersSelect.reset();

            for(var i = 0; i < team.members.length; i++) {
                var member = team.members[i];
                var value = member.id.toString();
                this.refs.usersSelect.select(value);
            }
        }

        /**
         * save
         * Save users in team
         * @param {Number} team id
         */

        this.save = function(switcheryTag) {
            var data = {
                csrfmiddlewaretoken: deeplegal.Util.getCsrf(),
                members: this.refs.usersSelect.getSelectedItems()
            };
            $.ajax({
                method: 'PUT',
                url: WS.teams + this.currentItem + '/',
                data: data,
                beforeSend: function() {
                    //deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                if(r.status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose('saved', 'alert-success');
                    self.loadTeams();
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
                url: WS.teams + this.currentItem + '/',
                data: data,
                beforeSend: function() {
                    deeplegal.Util.showLoading();
                }
            }).done(function(r) {
                if(r.status == 200) {
                    var saved = deeplegal.HTMLSnippets.getSnippet('saved');
                    deeplegal.Util.showMessageAutoClose('saved', 'alert-success');
                    self.loadTeams();
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
            this.loadTeams();
            this.loadUsers();

            $(this.refs.modalEdit).on('hidden.bs.modal', function (e) {
                self.clearCurrentItem();
            });

            $(this.refs.modalDelete).on('hidden.bs.modal', function (e) {
                self.clearCurrentItem();
            });

            $(this.refs.modalAdd).on('hidden.bs.modal', function(e) {
                self.refs.teamName.value = '';
            });
        })

        // Listener for editing options
        deeplegal.on('editOptionPanel', function(option) {
            self.currentItem = option.id;
            self.currentTitle = self.teams[option.index].name;
            self.updateMultiselect(option);
            self.update();
            $(self.refs.modalEdit).modal('show');
        })

        // Listener for deleting a panel options
        deeplegal.on('deleteOptionPanel', function(option) {
            self.currentItem = option.id;
            self.currentTitle = self.teams[option.index].name;
            self.update();
            $(self.refs.modalDelete).modal('show');
        })


    </script>
</teams>
