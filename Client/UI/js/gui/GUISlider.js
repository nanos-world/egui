class GUISlider extends GUIInputBase {
    constructor(id, x, y, width, height, value, min, max, parent) {
        super(id, x, y, width, height, parent);

        this.value = value;
        this.min = min;
        this.max = max;

        this.render();
        this.update();
    }

    render() {
        super.render();

        this.baseDiv.classList.add('gui-slider-container');

        this.input = document.createElement('input');
		this.input.type = 'range';
        this.input.addEventListener('input', this.onInput.bind(this));
        this.input.classList.add('gui-slider');
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

		this.input.min = this.min;
		this.input.max = this.max;
		this.input.value = this.value;
    }

	onInput(event) {
		this.value = event.target.value;
		EventsWrapper.CallDebounced('GUISliderChange_' + this.id, 'GUISliderChange', this.id, event.target.value);
	}

	setValue(value) {
		this.value = value;
		this.update();
	}

	setMin(min) {
		this.min = min;
		this.update();
	}

	setMax(max) {
		this.max = max;
		this.update();
	}
}

EventsWrapper.Subscribe('GUISliderCreate', (id, x, y, width, height, value, min, max, parent) => {
    new GUISlider(id, x, y, width, height, value, min, max, parent);
});

EventsWrapper.Subscribe('GUISliderSetValue', (id, value) => {
    const element = guiManager.get(id);

    if (element) {
        element.setValue(value);
    }
});

EventsWrapper.Subscribe('GUISliderSetMin', (id, min) => {
    const element = guiManager.get(id);

    if (element) {
        element.setMin(min);
    }
});

EventsWrapper.Subscribe('GUISliderSetMax', (id, max) => {
    const element = guiManager.get(id);

    if (element) {
        element.setMax(max);
    }
});
