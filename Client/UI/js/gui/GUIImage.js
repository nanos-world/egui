class GUIImage extends GUIElement {
    constructor(id, x, y, width, height, path, parent) {
        super(id, x, y, width, height, parent);

        this.path = path;
		this.fit = 'none';

        this.render();
        this.update();
    }

    render() {
        super.render();

        this.baseDiv.classList.add('gui-image-container');

        this.image = document.createElement('img');
		this.image.draggable = false;
        this.baseDiv.append(this.image);
    }

    delete() {
        super.delete();

        if (this.image) {
			this.image.parentNode.removeChild(this.image);

            this.image = null;
        }
    }

    update() {
        super.update();

		this.image.src = this.path;
		this.image.style.objectFit = this.fit;
    }

	setImage(path) {
		this.path = path;
		this.update();
	}

	setFit(fit) {
		this.fit = fit;
		this.update();
	}
}

EventsWrapper.Subscribe('GUIImageCreate', (id, x, y, width, height, path, parent) => {
    new GUIImage(id, x, y, width, height, path, parent);
});

EventsWrapper.Subscribe('GUIImageSetImage', (id, path) => {
    const element = guiManager.get(id);

    if (element) {
        element.setImage(path);
    }
});

EventsWrapper.Subscribe('GUIImageSetFit', (id, fit) => {
    const element = guiManager.get(id);

    if (element) {
        element.setFit(fit);
    }
});
