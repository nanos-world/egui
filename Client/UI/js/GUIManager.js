class GUIManager {
    /*
    elements
    */

    constructor() {
        this.elements = [];
    }

    register(id, element) {
        this.elements[id] = element;
    }

    unregister(id) {
		this.elements[id] = null;
    }

    get(id) {
        return this.elements[id];
    }
}

guiManager = new GUIManager();
