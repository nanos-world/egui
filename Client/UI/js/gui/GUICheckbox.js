class GUICheckbox extends GUIInputBase {
    constructor(id, x, y, width, height, text, parent) {
        super(id, x, y, width, height, parent);

        this.text = text;
        this.checked = false;

        this.render();
        this.update();
    }

    render() {
        super.render();

        this.baseDiv.classList.add('gui-checkbox-container');

        this.checkbox = document.createElement('input');
		this.checkbox.disabled = !this.enabled;
        this.checkbox.setAttribute('id', this.id + '_checkbox');
        this.checkbox.setAttribute('type', 'checkbox');
        this.checkbox.classList.add('gui-checkbox');
        this.checkbox.addEventListener('input', this.onInput.bind(this));
        this.baseDiv.append(this.checkbox);

		this.checkboxOverlay = document.createElement('div');
		this.checkboxOverlay.classList.add('gui-checkbox-overlay');
		this.baseDiv.append(this.checkboxOverlay);

        this.checkboxLabel = document.createElement('label');
    	this.checkboxLabel.setAttribute('for', this.id + '_checkbox');
        this.checkboxLabel.classList.add('gui-checkbox-label');
        this.baseDiv.append(this.checkboxLabel);
    }

    delete() {
        super.delete();

        if (this.checkbox) {
			this.checkbox.parentNode.removeChild(this.checkbox);

            this.checkbox = null;
        }

        if (this.checkboxOverlay) {
			this.checkboxOverlay.parentNode.removeChild(this.checkboxOverlay);

            this.checkboxOverlay = null;
        }

        if (this.checkboxLabel) {
			this.checkboxLabel.parentNode.removeChild(this.checkboxLabel);

            this.checkboxLabel = null;
        }
    }

    update() {
        super.update();

		this.baseDiv.style.display = this.visible ? 'flex' : 'none';

        this.checkbox.checked = this.checked;
        this.checkbox.style.width = this.height + 'px';

        this.checkboxOverlay.style.width = (this.height - 4) + 'px';

		this.checkboxLabel.innerText = this.text;
        this.checkboxLabel.style.lineHeight = this.height + 'px';
    }

	onInput(event) {
		this.value = event.target.value;
		EventsWrapper.CallDebounced('GUICheckboxChange_' + this.id, 'GUICheckboxChange', this.id, event.target.checked);
	}

    setText(value) {
        this.text = value;
        this.update();
    }

	setChecked(state) {
		this.checked = state;
		this.update();
	}
}

EventsWrapper.Subscribe('GUICheckboxCreate', (id, x, y, width, height, text, parent) => {
    new GUICheckbox(id, x, y, width, height, text, parent);
});

EventsWrapper.Subscribe('GUICheckboxSetChecked', (id, state) => {
    const element = guiManager.get(id);

    if (element) {
        element.setChecked(state);
    }
});

EventsWrapper.Subscribe('GUICheckboxSetText', (id, text) => {
    const element = guiManager.get(id);

    if (element) {
        element.setText(text);
    }
});

