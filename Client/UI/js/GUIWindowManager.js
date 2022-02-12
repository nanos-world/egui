class GUIWindowManager {
	constructor() {
        this.windows = [];
        this.dragWindow = [];
		document.addEventListener("mouseup", this.onDragEnd.bind(this));
		document.addEventListener("mousemove", this.onMouseMove.bind(this));
	}

	register(window) {
		this.windows.push(window);
	}

	unregister(window) {
		var index = this.windows.indexOf(window);
		if (index !== -1) {
		  this.windows.splice(index, 1);
		}
	}

	onMouseDown(window) {
		window.bringToFront();
	}

	onDragStart(window) {
		this.dragWindow = window;
	}

	onDragEnd() {
		this.dragWindow = null;
	}

	onMouseMove(event) {
		if (this.dragWindow !== null && typeof(this.dragWindow.onMouseMove) === 'function') {
			this.dragWindow.onMouseMove(event);
		}
	}
}
