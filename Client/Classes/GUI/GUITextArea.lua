EGUI.TextArea = EGUI.Classlib.Inherit(EGUI.InputBase)
EGUI.TextArea.Type = "TextArea"

EGUI.Manager:Subscribe(EGUI.TextArea.Type, "GUITextAreaChange")
EGUI.Manager:Subscribe(EGUI.TextArea.Type, "GUITextAreaFocusIn")
EGUI.Manager:Subscribe(EGUI.TextArea.Type, "GUITextAreaFocusOut")

function EGUI.TextArea:Constructor(posX, posY, width, height, parent)
	EGUI.Utils.CheckArgs("EGUI.TextArea:Constructor", "number", "number", "number", "number", "?table")
    EGUI.InputBase.Constructor(self, posX, posY, width, height, parent)

	self.m_Value = ""
	self.m_Placeholder = ""
	self.m_MaxLength = -1

    EGUI.Manager:CallEvent("GUITextAreaCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.TextArea:SetValue(value)
	EGUI.Utils.CheckArgs("EGUI.TextArea:SetValue", "string")
	self.m_Value = value
	EGUI.Manager:CallEvent("GUITextAreaSetValue", self:GetId(), self.m_Value)
	return self
end

function EGUI.TextArea:GetValue()
	return self.m_Value
end

function EGUI.TextArea:SetPlaceholder(value)
	EGUI.Utils.CheckArgs("EGUI.TextArea:SetPlaceholder", "number")
	self.m_Placeholder = value
	EGUI.Manager:CallEvent("GUITextAreaSetPlaceholder", self:GetId(), self.m_Placeholder)
	return self
end

function EGUI.TextArea:GetPlaceholder()
	return self.m_Placeholder
end

function EGUI.TextArea:SetMaxLength(value)
	EGUI.Utils.CheckArgs("EGUI.TextArea:SetMaxLength", "number")
	self.m_MaxLength = value
	EGUI.Manager:CallEvent("GUITextAreaSetMaxLength", self:GetId(), self.m_MaxLength)
	return self
end

function EGUI.TextArea:GetMaxLength()
	return self.m_MaxLength
end

function EGUI.TextArea:HandleEvent(event, ...)
    if event == "GUITextAreaChange" then
		local params = {...}
		self.m_Value = params[1]

        self:Trigger("Change", ...)
	elseif event == "GUITextAreaFocusIn" then
		EGUI.Manager:InputFocusIn(self)
        self:Trigger("FocusIn")
	elseif event == "GUITextAreaFocusOut" then
		EGUI.Manager:InputFocusOut(self)
        self:Trigger("FocusOut")
    end
end
