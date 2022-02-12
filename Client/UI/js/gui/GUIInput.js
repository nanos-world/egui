class GUIInput extends GUIInputBase {
    constructor(id, x, y, width, height, type, parent) {
        super(id, x, y, width, height, parent);
        this.type = type;
		this.value = '';
		this.placeholder = '';
		this.maxLength = -1;

        this.render();
        this.update();
    }

    render() {
        super.render();

        this.input = document.createElement('input');
		this.input.disabled = !this.enabled;
        this.input.classList.add('gui-input');
        this.input.addEventListener('input', this.onInput.bind(this));
        this.input.addEventListener('focusin', this.onFocusIn.bind(this));
        this.input.addEventListener('focusout', this.onFocusOut.bind(this));
        this.baseDiv.append(this.input);
    }

    delete() {
        super.delete();

        if (this.input) {
			this.input.parentNode.removeChild(this.input);

            this.input = null;
        }
    }

    update() {
        super.update();

        this.input.setAttribute('type', this.type);
        this.input.value = this.value;
        this.input.placeholder = this.placeholder;

		if (this.maxLength === -1) {
			this.input.removeAttribute('maxLength');
		} else {
			this.input.maxLength = this.maxLength;
		}
    }

	onInput(event) {
		this.value = event.target.value;
		EventsWrapper.CallDebounced('GUIInputChange_' + this.id, 'GUIInputChange', this.id, event.target.value);
	}

	onFocusIn() {
		EventsWrapper.Call('GUIInputFocusIn', this.id);
	}

	onFocusOut() {
		EventsWrapper.Call('GUIInputFocusOut', this.id);
	}

	setValue(value) {
		this.value = value;
		this.update();
	}

	setPlaceholder(value) {
		this.placeholder = value;
		this.update();
	}

	setType(type) {
		this.type = type;
		this.update();
	}

	setMaxLength(value) {
		this.maxLength = value;
		this.update();
	}
}

EventsWrapper.Subscribe('GUIInputCreate', (id, x, y, width, height, type, parent) => {
    new GUIInput(id, x, y, width, height, type, parent);
});

EventsWrapper.Subscribe('GUIInputSetValue', (id, value) => {
    const element = guiManager.get(id);

    if (element) {
        element.setValue(value);
    }
});

EventsWrapper.Subscribe('GUIInputSetType', (id, type) => {
    const element = guiManager.get(id);

    if (element) {
        element.setType(type);
    }
});

EventsWrapper.Subscribe('GUIInputSetPlaceholder', (id, value) => {
    const element = guiManager.get(id);

    if (element) {
        element.setPlaceholder(value);
    }
});

EventsWrapper.Subscribe('GUIInputSetMaxLength', (id, value) => {
    const element = guiManager.get(id);

    if (element) {
        element.setMaxLength(value);
    }
});
