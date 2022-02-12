class GUIButton extends GUIInputBase {
    constructor(id, x, y, width, height, text, parent) {
        super(id, x, y, width, height, parent);
        this.text = text;

        this.buttonStyle = 'default';
        this.buttonStyleColor = 'primary';

        this.render();
        this.update();
    }

    render() {
        super.render();

        this.button = document.createElement('button');
        this.button.classList.add('gui-button')
        this.button.addEventListener('mousedown', this.onMouseDown.bind(this), true);
        this.button.addEventListener('mouseup', this.onMouseUp.bind(this), true);
        this.baseDiv.append(this.button);
    }

    delete() {
        super.delete();

        if (this.button) {
            if (this.button) {
                this.button.parentNode.removeChild(this.button);
            }

            this.button = null;
        }
    }

    update() {
        super.update();

        this.button.innerText = this.text;
		this.button.disabled = !this.enabled;

        for (var i = this.button.classList.length - 1; i >= 0; i--) {
            var className = this.button.classList[i];

            if (className.startsWith('gui-button-style-') ||
                className.startsWith('gui-button-color-')) {
                this.button.classList.remove(className);
            }
        }

        this.button.classList.add('gui-button-style-' + this.buttonStyle);
        this.button.classList.add('gui-button-color-' + this.buttonStyleColor);
    }

    onMouseUp() {
		EventsWrapper.Call('GUIButtonMouseUp', this.id);
    }

    onMouseDown() {
		EventsWrapper.Call('GUIButtonMouseDown', this.id);
    }

    setStyle(color, style) {
        this.buttonStyle = style ? style : 'default';
        this.buttonStyleColor = color ? color : 'primary';
        this.update();
    }

    setText(text) {
        this.text = text;
        this.update();
    }
}

EventsWrapper.Subscribe('GUIButtonCreate', (id, x, y, width, height, text, parent) => {
    new GUIButton(id, x, y, width, height, text, parent);
});

EventsWrapper.Subscribe('GUIButtonSetColorStyle', (id, color, style) => {
    const element = guiManager.get(id);

    if (element) {
        element.setStyle(color, style);
    }
});

EventsWrapper.Subscribe('GUIButtonSetText', (id, text) => {
    const element = guiManager.get(id);

    if (element) {
        element.setText(text);
    }
});
