EGUI.Input = EGUI.Classlib.Inherit(EGUI.InputBase)
EGUI.Input.Type = "Input"

EGUI.Input.Types = {
	Text = "text",
	Password = "password"
}

EGUI.Manager:Subscribe(EGUI.Input.Type, "GUIInputChange")
EGUI.Manager:Subscribe(EGUI.Input.Type, "GUIInputFocusIn")
EGUI.Manager:Subscribe(EGUI.Input.Type, "GUIInputFocusOut")

function EGUI.Input:Constructor(posX, posY, width, height, parent)
	EGUI.Utils.CheckArgs("EGUI.Input:Constructor", "number", "number", "number", "number", "?table")
    EGUI.InputBase.Constructor(self, posX, posY, width, height, parent)

    self.m_Type = "text"
	self.m_Value = ""
	self.m_Placeholder = ""
	self.m_MaxLength = -1

    EGUI.Manager:CallEvent("GUIInputCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Type, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.Input:SetValue(value)
	EGUI.Utils.CheckArgs("EGUI.Input:SetValue", "string")
	self.m_Value = value
	EGUI.Manager:CallEvent("GUIInputSetValue", self:GetId(), self.m_Value)
	return self
end

function EGUI.Input:GetValue()
	return self.m_Value
end

function EGUI.Input:SetType(type)
	EGUI.Utils.CheckArgs("EGUI.Input:SetType", "string")
	self.m_Type = type
	EGUI.Manager:CallEvent("GUIInputSetType", self:GetId(), self.m_Type)
	return self
end

function EGUI.Input:GetType()
	return self.m_Type
end

function EGUI.Input:SetPlaceholder(value)
	EGUI.Utils.CheckArgs("EGUI.Input:SetPlaceholder", "string")
	self.m_Placeholder = value
	EGUI.Manager:CallEvent("GUIInputSetPlaceholder", self:GetId(), self.m_Placeholder)
	return self
end

function EGUI.Input:GetPlaceholder()
	return self.m_Placeholder
end

function EGUI.Input:SetMaxLength(maxLength)
	EGUI.Utils.CheckArgs("EGUI.Input:SetMaxLength", "number")
	self.m_MaxLength = maxLength
	EGUI.Manager:CallEvent("GUIInputSetMaxLength", self:GetId(), self.m_MaxLength)
	return self
end

function EGUI.Input:GetMaxLength()
	return self.m_MaxLength
end

function EGUI.Input:HandleEvent(event, ...)
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
