class GUIWindow extends GUIElement {
    constructor(id, x, y, width, height, title, titlebarEnabled, closeButtonEnabled, parent) {
        super(id, x, y, width, height, parent);
        this.title = title;
        this.titlebarEnabled = titlebarEnabled;
        this.closeButtonEnabled = closeButtonEnabled;

		this.render();
        this.update();

		guiWindowManager.register(this);
    }

	destructor() {
        super.destructor();

		guiWindowManager.unregister(this);
	}

    render() {
        super.render();

        this.baseDiv.classList.add('gui-window')
		this.baseDiv.addEventListener("mousedown", this.onMouseDown.bind(this));

        if (this.titlebarEnabled) {
            this.createTitlebar();
        }

        if (this.closeButtonEnabled) {
            this.createCloseButton();
        }

        this.bodyDiv = document.createElement('div');
        this.bodyDiv.classList.add('gui-window-body');

        if (this.titlebarEnabled) {
            this.bodyDiv.classList.add('gui-window-body-with-title');
        }

        this.baseDiv.append(this.bodyDiv);
    }

    delete() {
        super.delete();

        if (this.bodyDiv) {
            if (this.bodyDiv) {
                this.bodyDiv.parentNode.removeChild(this.bodyDiv);
            }

            this.bodyDiv = null;
        }
    }

    update() {
        super.update();

        if (this.titleSpan) {
            this.titleSpan.innerText = this.title;
        }

        if (this.titlebarEnabled) {
        }


        if (this.titlebarEnabled) {
            this.createTitlebar();
        } else {
            this.destroyTitlebar();
        }

        if (this.closeButtonEnabled) {
            this.createCloseButton();
        } else {
            this.destroyCloseButton();
        }
    }

    createTitlebar() {
        if (!this.headerDiv) {
            this.headerDiv = document.createElement('div');
            this.headerDiv.classList.add('gui-window-header')
            this.baseDiv.append(this.headerDiv);

			this.headerDragHandle = document.createElement('div');
			this.headerDragHandle.classList.add('gui-window-drag-handle');
			if (this.closeButtonEnabled) {
				this.headerDragHandle.classList.add('gui-window-drag-handle-with-close');
			}
            this.headerDragHandle.addEventListener("mousedown", this.onDragStart.bind(this), true);
            this.headerDiv.append(this.headerDragHandle);

            this.titleSpan = document.createElement('span');
            this.titleSpan.classList.add('gui-window-title')
            this.headerDragHandle.append(this.titleSpan);
        }
    }

    destroyTitlebar() {
        if (this.headerDiv) {
            this.destroyCloseButton();
            this.headerDiv.parentNode.removeChild(this.headerDiv);
            this.headerDiv = nil;
        }
    }

    createCloseButton() {
        if (this.headerDiv && !this.buttonClose) {
            this.buttonClose = document.createElement('button');
            this.buttonClose.classList.add('gui-window-close')
            this.buttonClose.innerText = 'X';
			this.buttonClose.addEventListener('click', this.onCloseClick.bind(this), true);
			this.buttonClose.addEventListener('mousedown', this.onCloseUpDown.bind(this), true);
			this.buttonClose.addEventListener('mouseup', this.onCloseUpDown.bind(this), true);
            this.headerDiv.append(this.buttonClose);
        }
    }

    destroyCloseButton() {
        if (this.headerDiv && this.buttonClose) {
            this.buttonClose.parentNode.removeChild(this.buttonClose);
            this.buttonClose = nil;
        }
    }

	onDragStart(event) {
        this.dragStartX = event.pageX;
        this.dragStartY = event.pageY;
		guiWindowManager.onDragStart(this);
	}

	onMouseDown() {
		guiWindowManager.onMouseDown(this);
	}

	onMouseMove(event) {
		var deltaX = event.pageX - this.dragStartX;
		var deltaY = event.pageY - this.dragStartY;
        this.dragStartX = event.pageX;
        this.dragStartY = event.pageY;
		var rect = this.baseDiv.getBoundingClientRect();

		this.x = rect.x + deltaX;
		this.y = rect.y + deltaY;
		this.baseDiv.style.left = this.x + 'px';
		this.baseDiv.style.top  = this.y + 'px';

		EventsWrapper.CallDebounced('GUIWindowMove_' + this.id, 'GUIWindowMove', this.id, this.x, this.y);
	}

	onCloseClick() {
		EventsWrapper.Call('GUIWindowCloseClick', this.id);
	}

	onCloseUpDown(event) {
		event.stopPropagation();
	}

    setTitle(title) {
        this.title = title;
        this.update();
    }

    setCloseButtonEnabled(enabled) {
        this.closeButtonEnabled = enabled;
        this.update();
    }

    setTitelbarEnabled(enabled) {
        this.titlebarEnabled = enabled;
        this.update();
    }

    addChild(child) {
		super.addChild(child);
        this.bodyDiv.append(child.baseDiv);
    }

	bringToFront() {
		if (this.baseDiv.parentNode.children[this.baseDiv.parentNode.children.length - 1] !== this.baseDiv) {
			this.baseDiv.parentNode.appendChild(this.baseDiv);
		}
	}
}

EventsWrapper.Subscribe('GUIWindowCreate', (id, x, y, width, height, title, titlebarEnabled, closeButtonEnabled, parent) => {
    new GUIWindow(id, x, y, width, height, title, titlebarEnabled, closeButtonEnabled, parent);
});

EventsWrapper.Subscribe('GUIWindowSetTitle', (id, title) => {
    const element = guiManager.get(id);

    if (element) {
        element.setTitle(title);
    }
});

EventsWrapper.Subscribe('GUIWindowSetCloseButtonEnabled', (id, enabled) => {
    const element = guiManager.get(id);

    if (element) {
        element.setCloseButtonEnabled(enabled);
    }
});

EventsWrapper.Subscribe('GUIWindowSetTitelbarEnabled', (id, enabled) => {
    const element = guiManager.get(id);

    if (element) {
        element.setTitelbarEnabled(enabled);
    }
});

EventsWrapper.Subscribe('GUIWindowBringToFront', (id) => {
    const element = guiManager.get(id);

    if (element) {
        element.bringToFront();
    }
});
