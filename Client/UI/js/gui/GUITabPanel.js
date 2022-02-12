class GUIPanelTab extends GUIElement {
    constructor(id, x, y, width, height, parent) {
        super(id, x, y, width, height, parent);

		this.tabs = [];

        this.render();
        this.update();
    }


    render() {
        super.render();

        this.baseDiv.classList.add('gui-tab-container');

        this.header = document.createElement('div');
        this.header.classList.add('gui-tab-header');
        this.baseDiv.append(this.header);

        this.body = document.createElement('div');
        this.body.classList.add('gui-tab-body');
        this.baseDiv.append(this.body);

        this.nav = document.createElement('nav');
        this.header.append(this.nav);
    }

	addTabMenu(child) {
		var tab = document.createElement('a');
		tab.classList.add('gui-tab-nav-tab');
        tab.addEventListener('mousedown', this.onTabClick.bind(this, child.id), true);
        this.nav.append(tab);

        var tabText = document.createElement('span');
		tabText.innerText = child.name;
        tab.append(tabText);

		return {tab: tab, tabText: tabText};
	}

	onTabClick(id) {
		for(var tab of this.tabs) {
			if (tab.id === id) {
				tab.tab.setVisible(true);
                tab.menuDiv.tab.classList.add('gui-tab-nav-tab-active');
			} else {
				tab.tab.setVisible(false);
                tab.menuDiv.tab.classList.remove('gui-tab-nav-tab-active');
			}
		}
	}

    addChild(child) {
		super.addChild(child);

        this.body.append(child.baseDiv);
		child.setVisible(false);

		this.tabs.push({
			id: child.id,
			tab: child,
			tabDiv: child.baseDiv,
			menuDiv: this.addTabMenu(child)
		});

		if (this.tabs.length === 1) {
			this.onTabClick(child.id);
		}
    }

}

EventsWrapper.Subscribe('GUITabPanelCreate', (id, x, y, width, height, parent) => {
    new GUIPanelTab(id, x, y, width, height, parent);
});
