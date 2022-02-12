class GUITab extends GUIElement {
    constructor(id, name, parent) {
        super(id, 0, 0, 1, 1, parent);

		this.name = name;

        this.render();
        this.update();
    }


    render() {
        super.render();
    }

	update() {
		super.update();
	}

    addChild(child) {
		super.addChild(child);
        this.baseDiv.append(child.baseDiv);
    }
}

EventsWrapper.Subscribe('GUITabCreate', (id, name, parent) => {
    new GUITab(id, name, parent);
});
