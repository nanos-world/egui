document.addEventListener('DOMContentLoaded', () => {
	guiWindowManager = new GUIWindowManager();
	guiElements = {};

	if (Events.Trigger) {
		var id = 1;
		var nextId = function() { const t = id; id++; return t; }

		var window1 = nextId();
		Events.Trigger('GUIWindowCreate', window1, 100, 100, 260, 210, 'Buttons', true, true);
		var button1 = nextId();
		Events.Trigger('GUIButtonCreate', button1, 5, 5, 80, 30, 'Visible', window1);
		var button2 = nextId();
		Events.Trigger('GUIButtonCreate', button2, 5, 40, 80, 30, 'Alpha', window1);
		var button3 = nextId();
		Events.Trigger('GUIButtonCreate', button3, 5, 75, 80, 30, 'Enabled', window1);
		var button4 = nextId();
		Events.Trigger('GUIButtonCreate', button4, 90, 75, 80, 30, 'Test', window1);
		Events.Trigger('GUIButtonCreate', nextId(), 5, 165, 80, 30, 'Default', window1);

		var window2 = nextId();
		Events.Trigger('GUIWindowCreate', window2, 400, 100, 260, 210, 'Buttons 2', true, false);
		Events.Trigger('GUIButtonCreate', nextId(), 5, 5, 80, 30, 'Default', window2);

		var window3 = nextId();
		Events.Trigger('GUIWindowCreate', window3, 700, 100, 260, 210, 'LEL', false, true);
		Events.Trigger('GUIButtonCreate', nextId(), 5, 5, 160, 30, 'Default', window3);
		Events.Trigger('GUIButtonCreate', nextId(), 5, 175, 80, 30, 'Default', window3);
		Events.Trigger('GUIButtonCreate', nextId(), 170, 5, 80, 30, 'Default', window3);
		Events.Trigger('GUIButtonCreate', nextId(), 170, 40, 80, 30, 'Default', window3);
		var input1 = nextId();
		Events.Trigger('GUIInputCreate', input1, 5, 40, 160, 30, 'text', window3);
		Events.Trigger('GUIInputSetValue', input1, 'Mehh');
		var checkbox1 = nextId();
		Events.Trigger('GUICheckboxCreate', checkbox1, 5, 75, 80, 30, 'Test', window3);
		var button5 = nextId();
		Events.Trigger('GUIButtonCreate', button5, 5, 110, 80, 30, 'Toggle', window3);
		Events.Trigger('GUIImageCreate', nextId(), 90, 75, 120, 95, 'https://i.imgur.com/EKPBd4R.png', window3);
		Events.Trigger('GUILabelCreate', nextId(), 90, 175, 80, 30, 'Test', window3);

		Events.Trigger('GUIElementSetAlpha', window2, 0.5);


		var visible = true;
		var enabled = true;
		var checked = false;
		Events.SubscribeGame('GUIButtonMouseUp', function(id) {
			if (button1 == id) {
				visible = !visible;
				Events.Trigger('GUIElementSetVisible', window3, visible);
			} else if (button2 == id) {
				Events.Trigger('GUIElementSetAlpha', window2, Math.random());
			} else if (button3 == id) {
				enabled = !enabled;
				Events.Trigger('GUIInputBaseSetEnabled', button4, enabled);
			} else if (button5 == id) {
				checked = !checked;
				Events.Trigger('GUICheckboxSetChecked', checkbox1, checked);
			}
		});


		var longText = 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';
		var window4 = nextId();
		var label1 = nextId();
		Events.Trigger('GUIWindowCreate', window4, 1000, 100, 260, 210, '', true, true);
		Events.Trigger('GUILabelCreate', label1, 10, 10, 240, 160, longText, window4);
		Events.Trigger('GUILabelSetLineHeight', label1, 10);

		var window5 = nextId();
		var tabPanel1 = nextId();
		var tab1 = nextId();
		var tab2 = nextId();
		var tab3 = nextId();
		Events.Trigger('GUIWindowCreate', window5, 100, 350, 260, 210, '', true, true);
		Events.Trigger('GUITabPanelCreate', tabPanel1, 0, 0, 260, 180, window5);
		Events.Trigger('GUITabCreate', tab1, 'Foo', tabPanel1);
		Events.Trigger('GUITabCreate', tab2, 'Bar', tabPanel1);
		Events.Trigger('GUITabCreate', tab3, 'Oof', tabPanel1);

		Events.Trigger('GUIButtonCreate', nextId(), 5, 5, 80, 30, 'Foo Button', tab1);
		Events.Trigger('GUIButtonCreate', nextId(), 5, 5, 80, 30, 'Bar Button', tab2);
		Events.Trigger('GUIButtonCreate', nextId(), 5, 5, 80, 30, 'Oof Button', tab3);

		var window6 = nextId();
		Events.Trigger('GUIWindowCreate', window6, 400, 350, 260, 210, '', true, true);
		Events.Trigger('GUITextAreaCreate', nextId(), 5, 5, 250, 170, window6);

		var window7 = nextId();
		Events.Trigger('GUIWindowCreate', window7, 700, 350, 260, 210, '', true, true);
		Events.Trigger('GUISliderCreate', nextId(), 5, 5, 250, 30, 50, 0, 100, window7);

		var progressBar1 = nextId();
		Events.Trigger('GUIProgressBarCreate', progressBar1, 5, 40, 250, 30, window7);
		Events.Trigger('GUIProgressBarSetValue', progressBar1, 50);
	}
}, false);
