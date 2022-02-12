class GUILabel extends GUIElement {
    constructor(id, x, y, width, height, text, fontSize, lineHeight, parent) {
        super(id, x, y, width, height, parent);

        this.text = text;
		this.fontSize = fontSize;
		this.lineHeight = lineHeight;

        this.render();
        this.update();
    }

    render() {
        super.render();

        this.baseDiv.classList.add('gui-label-container');

        this.span = document.createElement('span');
        this.span.classList.add('gui-label');
        this.baseDiv.append(this.span);
    }

    delete() {
        super.delete();

        if (this.span) {
			this.span.parentNode.removeChild(this.span);

            this.span = null;
        }
    }

    update() {
        super.update();

		this.span.innerText = this.text;
		this.span.style.fontSize = this.fontSize + 'px';
        this.span.style.lineHeight = this.lineHeight + 'px';
    }

	setText(text) {
		this.text = text;
		this.update();
	}

	setFontSize(size) {
		this.fontSize = size;
		this.update();
	}

	setLineHeight(height) {
		this.lineHeight = height;
		this.update();
	}
}

EventsWrapper.Subscribe('GUILabelCreate', (id, x, y, width, height, text, fontSize, lineHeight, parent) => {
    new GUILabel(id, x, y, width, height, text, fontSize, lineHeight, parent);
});

EventsWrapper.Subscribe('GUILabelSetText', (id, text) => {
    const element = guiManager.get(id);

    if (element) {
        element.setText(text);
    }
});

EventsWrapper.Subscribe('GUILabelSetFontSize', (id, size) => {
    const element = guiManager.get(id);

    if (element) {
        element.setFontSize(size);
    }
});

EventsWrapper.Subscribe('GUILabelSetLineHeight', (id, height) => {
    const element = guiManager.get(id);

    if (element) {
        element.setLineHeight(height);
    }
});
