class GUIElement {
    constructor(id, x, y, width, height, parent) {
        this.id = id;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.parent = parent;
		this.alignment = 'topLeft';
		/*
			topLeft
			topRight
			bottomLeft
			bottomRight
		*/

		this.visible = true;
		this.alpha = 1;

		this.children = [];

        guiManager.register(this.id, this);
    }

	destructor() {
        this.delete();
		guiManager.unregister(this.id);
	}

    render() {
        this.delete();

        this.baseDiv = document.createElement('div');
        this.baseDiv.setAttribute('id', this.id);

        if (this.parent) {
            const parent = guiManager.get(this.parent);

            if (parent) {
                parent.addChild(this);
            } else {
                document.body.append(this.baseDiv);
            }
        } else {
            document.body.append(this.baseDiv);
        }
    }

    delete() {
        if (this.baseDiv) {
            this.baseDiv.parentNode.removeChild(this.baseDiv);
            this.baseDiv = null;
        }
    }

	destroy() {
		for (var index = this.children.length; index >= 0; index--) {
			const element = this.children[index];

			if (element) {
				element.delete();
			}
		}

		this.delete();
	}

    update() {
        this.baseDiv.style.position = 'absolute';

		if (this.alignment === 'topLeft') {
			this.baseDiv.style.left = this.x + 'px';
			this.baseDiv.style.top = this.y + 'px';
			this.baseDiv.style.right = null;
			this.baseDiv.style.bottom = null;
		} else if (this.alignment === 'topRight') {
			this.baseDiv.style.left = null;
			this.baseDiv.style.top = this.y + 'px';
			this.baseDiv.style.right = this.x + 'px';
			this.baseDiv.style.bottom = null;
		} else if (this.alignment === 'bottomLeft') {
			this.baseDiv.style.left = this.x + 'px';
			this.baseDiv.style.top = null;
			this.baseDiv.style.right = null;
			this.baseDiv.style.bottom = this.y + 'px';
		} else if (this.alignment === 'bottomRight') {
			this.baseDiv.style.left = null;
			this.baseDiv.style.top = null;
			this.baseDiv.style.right = this.x + 'px';
			this.baseDiv.style.bottom = this.y + 'px';
		}

        this.baseDiv.style.width = this.width + 'px';
        this.baseDiv.style.height = this.height + 'px';

		this.baseDiv.style.display = this.visible ? 'block' : 'none';
		this.baseDiv.style.opacity = this.alpha;
    }

	setVisible(state) {
		this.visible = state;
		this.update();
	}

	setAlpha(alpha) {
		this.alpha = alpha;
		this.update();
	}

	setPosition(x, y) {
		this.x = x;
		this.y = y;
		this.update();
	}

	setSize(width, height) {
		this.width = width;
		this.height = height;
		this.update();
	}

	setAlignment(alignment) {
		this.alignment = alignment;
		this.update();
	}

    addChild(child) {
		this.children.push(child);
    }
}

EventsWrapper.Subscribe('GUIElementSetVisible', (id, state) => {
    const element = guiManager.get(id);

    if (element) {
        element.setVisible(state);
    }
});

EventsWrapper.Subscribe('GUIElementSetAlpha', (id, alpha) => {
    const element = guiManager.get(id);

    if (element) {
        element.setAlpha(alpha);
    }
});

EventsWrapper.Subscribe('GUIElementSetPosition', (id, x, y) => {
    const element = guiManager.get(id);

    if (element) {
        element.setPosition(x, y);
    }
});

EventsWrapper.Subscribe('GUIElementSetSize', (id, width, height) => {
    const element = guiManager.get(id);

    if (element) {
        element.setSize(width, height);
    }
});

EventsWrapper.Subscribe('GUIElementSetAlignment', (id, alignment) => {
    const element = guiManager.get(id);

    if (element) {
        element.setAlignment(alignment);
    }
});

EventsWrapper.Subscribe('GUIElementDestroy', (id) => {
    const element = guiManager.get(id);

    if (element) {
        element.destroy();
    }
});
