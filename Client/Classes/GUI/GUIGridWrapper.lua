local CUSTOM_GUI = 1
local offset = 0
local outMargin = 0
function grid(typ, pos, ignorecustom)
	if not ignorecustom then
		local erg = grid(typ, pos, true)
		return type(erg) == "number" and erg*CUSTOM_GUI or erg
	end
	if not pos then pos = 1 end
	if typ == "offset" then
		offset = pos
		return true
	elseif typ == "outMargin" then
		outMargin = pos
		return true
	elseif typ == "reset" then -- reset all previous settings
		offset = 0
		outMargin = 0
		return true
	elseif typ == "x" then
		return 30*(pos - 1) + 10*pos + outMargin
	elseif typ == "y" then
		return offset + 30*(pos - 1) + 10*pos + outMargin
	end
	return 30*pos + 10*(pos - 1)
end

EGUIGrid = {}
EGUIGrid.Window = EGUI.Classlib.Inherit(EGUI.Window)
EGUIGrid.Button = EGUI.Classlib.Inherit(EGUI.Button)
EGUIGrid.Input = EGUI.Classlib.Inherit(EGUI.Input)
EGUIGrid.Label = EGUI.Classlib.Inherit(EGUI.Label)
EGUIGrid.Slider = EGUI.Classlib.Inherit(EGUI.Slider)
EGUIGrid.TextArea = EGUI.Classlib.Inherit(EGUI.TextArea)
EGUIGrid.Image = EGUI.Classlib.Inherit(EGUI.Image)
EGUIGrid.Checkbox = EGUI.Classlib.Inherit(EGUI.Checkbox)
EGUIGrid.TabPanel = EGUI.Classlib.Inherit(EGUI.TabPanel)
EGUIGrid.ProgressBar = EGUI.Classlib.Inherit(EGUI.ProgressBar)

function EGUIGrid.Window:Constructor(posX, posY, width, height, title, hasTitlebar, hasCloseButto, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.Window:Constructor", "number", "number", "number", "number", "string", "?boolean", "?boolean", "?table")
    return EGUI.Window.Constructor(self, posX, posY, grid("x", width), grid("y", height) + (hasTitlebar and 30 or 0), title, hasTitlebar, hasCloseButto, parent)
end

function EGUIGrid.Button:Constructor(posX, posY, width, height, text, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.Button:Constructor", "number", "number", "number", "number", "string", "?table")
    return EGUI.Button.Constructor(self, grid("x", posX), grid("y", posY), grid("d", width), grid("d", height), text, parent)
end

function EGUIGrid.Input:Constructor(posX, posY, width, height, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.Input:Constructor", "number", "number", "number", "number", "?table")
    return EGUI.Input.Constructor(self, grid("x", posX), grid("y", posY), grid("d", width), grid("d", height), parent)
end

function EGUIGrid.Label:Constructor(posX, posY, width, height, text, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.Label:Constructor", "number", "number", "number", "number", "string", "?table")
    return EGUI.Label.Constructor(self, grid("x", posX), grid("y", posY), grid("d", width), grid("d", height), text, parent)
end

function EGUIGrid.Slider:Constructor(posX, posY, width, height, value, min, max, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.Slider:Constructor", "number", "number", "number", "number", "number", "number", "number", "?table")
    return EGUI.Slider.Constructor(self, grid("x", posX), grid("y", posY), grid("d", width), grid("d", height), value, min, max, parent)
end

function EGUIGrid.TextArea:Constructor(posX, posY, width, height, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.TextArea:Constructor", "number", "number", "number", "number", "?table")
    return EGUI.TextArea.Constructor(self, grid("x", posX), grid("y", posY), grid("d", width), grid("d", height), parent)
end

function EGUIGrid.Image:Constructor(posX, posY, width, height, path, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.Image:Constructor", "number", "number", "number", "number", "string", "?table")
    return EGUI.Image.Constructor(self, grid("x", posX), grid("y", posY), grid("d", width), grid("d", height), path, parent)
end

function EGUIGrid.Checkbox:Constructor(posX, posY, width, height, text, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.Checkbox:Constructor", "number", "number", "number", "number", "string", "?table")
    return EGUI.Checkbox.Constructor(self, grid("x", posX), grid("y", posY), grid("d", width), grid("d", height), text, parent)
end

function EGUIGrid.TabPanel:Constructor(posX, posY, width, height, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.TabPanel:Constructor", "number", "number", "number", "number", "?table")
    return EGUI.TabPanel.Constructor(self, grid("x", posX), grid("y", posY), grid("d", width), grid("d", height), parent)
end

function EGUIGrid.ProgressBar:Constructor(posX, posY, width, height, parent)
	EGUI.Utils.CheckArgs("EGUIGrid.ProgressBar:Constructor", "number", "number", "number", "number", "?table")
    return EGUI.ProgressBar.Constructor(self, grid("x", posX), grid("y", posY), grid("d", width), grid("d", height), parent)
end
