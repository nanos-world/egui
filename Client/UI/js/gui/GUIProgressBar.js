class GUIProgressBar extends GUIElement {
    constructor(id, x, y, width, height, parent) {
        super(id, x, y, width, height, parent);

        this.value = 0;

        this.render();
        this.update();
    }

    render() {
        super.render();

        this.baseDiv.classList.add('gui-progressbar-container');

        this.progressOuter = document.createElement('div');
        this.progressOuter.classList.add('gui-progressbar-outer');
        this.baseDiv.append(this.progressOuter);

        this.progressInner = document.createElement('div');
        this.progressInner.classList.add('gui-progressbar-inner');
        this.progressOuter.append(this.progressInner);
    }

    delete() {
        super.delete();

        if (this.progressOuter) {
			this.progressInner.parentNode.removeChild(this.progressInner);
			this.progressOuter.parentNode.removeChild(this.progressOuter);

            this.progressOuter = null;
            this.progressInner = null;
        }
    }

    update() {
        super.update();

		this.progressInner.style.width = this.value + '%';
    }

	setValue(value) {
		this.value = value;
		this.update();
	}
}

EventsWrapper.Subscribe('GUIProgressBarCreate', (id, x, y, width, height, parent) => {
    new GUIProgressBar(id, x, y, width, height, parent);
});

EventsWrapper.Subscribe('GUIProgressBarSetValue', (id, value) => {
    const element = guiManager.get(id);

    if (element) {
        element.setValue(value);
    }
});
