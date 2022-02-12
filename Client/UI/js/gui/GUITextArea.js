class GUITextArea extends GUIInputBase {
    constructor(id, x, y, width, height, parent) {
        super(id, x, y, width, height, parent);
		this.value = '';
		this.placeholder = '';
		this.maxLength = -1;

        this.render();
        this.update();
    }

    render() {
        super.render();

        this.input = document.createElement('textarea');
		this.input.disabled = !this.enabled;
        this.input.classList.add('gui-textarea');
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

		this.input.innerText = this.value;
        this.input.placeholder = this.placeholder;

		if (this.maxLength === -1) {
			this.input.removeAttribute('maxLength');
		} else {
			this.input.maxLength = this.maxLength;
		}
    }

	onInput(event) {
		this.value = event.target.value;
		EventsWrapper.CallDebounced('GUITextAreaChange_' + this.id, 'GUITextAreaChange', this.id, event.target.value);
	}

	onFocusIn() {
		EventsWrapper.Call('GUITextAreaFocusIn', this.id);
	}

	onFocusOut() {
		EventsWrapper.Call('GUITextAreaFocusOut', this.id);
	}

	setValue(value) {
		this.value = value;
		this.update();
	}

	setPlaceholder(value) {
		this.placeholder = value;
		this.update();
	}

	setMaxLength(value) {
		this.maxLength = value;
		this.update();
	}
}

EventsWrapper.Subscribe('GUITextAreaCreate', (id, x, y, width, height, parent) => {
    new GUITextArea(id, x, y, width, height, parent);
});

EventsWrapper.Subscribe('GUITextAreaSetValue', (id, value) => {
    const element = guiManager.get(id);

    if (element) {
        element.setValue(value);
    }
});

EventsWrapper.Subscribe('GUITextAreaSetPlaceholder', (id, value) => {
    const element = guiManager.get(id);

    if (element) {
        element.setPlaceholder(value);
    }
});

EventsWrapper.Subscribe('GUITextAreaSetMaxLength', (id, value) => {
    const element = guiManager.get(id);

    if (element) {
        element.setMaxLength(value);
    }
});
