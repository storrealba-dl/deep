<switchery>
	<input class="checkbox" id="cb-{opts.label}" type="checkbox" ref="input" data-plugin="switchery" data-switchery="true" data-group="{opts.group}" value="{opts.inputValue}">
	<label class="checkbox-label" for="cb-{opts.label}">{opts.label}</label>
	<script>
		var self = this;
		this.switcheryObj;
		this.isMuted = false; //prevents triggering change event

		/**
		 * setSwitchery
		 * Sets the input to checked / unchecked 
		 * by default it won't trigger the change event
		 * @param {Boolean}
		 */

		this.setSwitchery = function(checkedBool, mute) {
			mute = mute || true;
			mute && this.mute();
			var switchElement = this.switcheryObj;
		    if((checkedBool && !switchElement.isChecked()) || (!checkedBool && switchElement.isChecked())) {
		        switchElement.setPosition(true);
		        switchElement.handleOnchange(true);
		    }
		    mute && this.unMute();
		}

		/**
		 * getData
		 * Returns the input info (id, name)
		 * @return {Object} input info
		 */

		this.getData = function() {
			return {
				id: this.opts.inputValue,
				name: this.opts.label,
				group: this.opts.group,
				checked: this.refs.input.checked
			}
		}

		this.mute = function() {
			this.isMuted = true;
		}

		this.unMute = function() {
			this.isMuted = false;
		}

		this.on('mount', function() {
			this.switcheryObj = new Switchery(this.refs.input, {color: this.opts.color});

			this.refs.input.onchange = function() {
				if(!self.isMuted) {
					deeplegal.trigger('saveSwitcheryStatus', self);
				}
			}
		})

		deeplegal.on('resetSwitcheryCheckbox', function() {
			self.setSwitchery(false);
		})
	</script>
</switchery>