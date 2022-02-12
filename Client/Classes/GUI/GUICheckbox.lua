EGUI.Checkbox = EGUI.Classlib.Inherit(EGUI.InputBase)
EGUI.Checkbox.Type = "Input"

EGUI.Manager:Subscribe(EGUI.Checkbox.Type, "GUIInputChange")
EGUI.Manager:Subscribe(EGUI.Checkbox.Type, "GUIInputFocusIn")
EGUI.Manager:Subscribe(EGUI.Checkbox.Type, "GUIInputFocusOut")

function EGUI.Checkbox:Constructor(posX, posY, width, height, text, parent)
	EGUI.Utils.CheckArgs("EGUI.Checkbox:Constructor", "number", "number", "number", "number", "string", "?table")
    EGUI.InputBase.Constructor(self, posX, posY, width, height, parent)

    self.m_Text = text
	self.m_Checked = false

    EGUI.Manager:CallEvent("GUICheckboxCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Text, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.Checkbox:SetChecked(state)
	EGUI.Utils.CheckArgs("EGUI.Checkbox:SetChecked", "boolean")
	self.m_Checked = state
	EGUI.Manager:CallEvent("GUICheckboxSetChecked", self:GetId(), self.m_Checked)
	return self
end

function EGUI.Checkbox:IsChecked()
	return self.m_Checked
end

function EGUI.Checkbox:SetText(text)
	EGUI.Utils.CheckArgs("EGUI.Checkbox:SetText", "string")
	self.m_Text = text
	EGUI.Manager:CallEvent("GUICheckboxSetText", self:GetId(), self.m_Placeholder)
	return self
end

function EGUI.Checkbox:GetText()
	return self.m_Text
end

function EGUI.Checkbox:HandleEvent(event, ...)
    if event == "GUIInputChange" then
		local params = {...}
		self.m_Value = params[1]

        self:Trigger("Change", ...)
	elseif event == "GUIInputFocusIn" then
		EGUI.Manager:InputFocusIn(self)
        self:Trigger("FocusIn")
	elseif event == "GUIInputFocusOut" then
		EGUI.Manager:InputFocusOut(self)
        self:Trigger("FocusOut")
    end
end
