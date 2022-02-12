EGUI = {}

EGUI.Color = {
    Primary     = "primary",
    Secondary   = "secondary",
    Success     = "success",
    Danger      = "danger",
    Warning     = "warning"
}

EGUI.Alignment = {
    TopLeft		= "topLeft",
    TopRight	= "topRight",
    BottomLeft	= "bottomLeft",
    BottomRight = "bottomRight"
}

local files = {
	"Utils.lua",
	"Classlib.lua",

	"Classes/Object.lua",
	"Classes/GUI/GUIManager.lua",
	"Classes/GUI/GUIElement.lua",
	"Classes/GUI/GUIInputBase.lua",
	"Classes/GUI/GUIWindow.lua",
	"Classes/GUI/GUIButton.lua",
	"Classes/GUI/GUIInput.lua",
	"Classes/GUI/GUITextArea.lua",
	"Classes/GUI/GUICheckbox.lua",
	"Classes/GUI/GUIImage.lua",
	"Classes/GUI/GUILabel.lua",
	"Classes/GUI/GUITab.lua",
	"Classes/GUI/GUITabPanel.lua",
	"Classes/GUI/GUISlider.lua",
	"Classes/GUI/GUIProgressBar.lua",

	"Classes/GUI/GUIGridWrapper.lua"
}

for _, file in ipairs(files) do
	Package.Require(file)
end
