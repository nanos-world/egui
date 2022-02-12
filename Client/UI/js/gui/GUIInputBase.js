class GUIInputBase extends GUIElement {
    constructor(id, x, y, width, height, parent) {
        super(id, x, y, width, height, parent);
        this.enabled = true;
    }

    setEnabled(state) {
        this.enabled = state;
		this.update();
    }
}

EventsWrapper.Subscribe('GUIInputBaseSetEnabled', (id, state) => {
    const element = guiManager.get(id);

    if (element) {
        element.setEnabled(state);
    }
});
