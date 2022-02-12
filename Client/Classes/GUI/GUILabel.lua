EGUI.Label = EGUI.Classlib.Inherit(EGUI.Element)
EGUI.Label.Type = "Label"

function EGUI.Label:Constructor(posX, posY, width, height, text, parent)
	EGUI.Utils.CheckArgs("EGUI.Label:Constructor", "number", "number", "number", "number", "string", "?table")
    EGUI.Element.Constructor(self, posX, posY, width, height, parent)

    self.m_Text = text
	self.m_FontSize = height > 30 and 30 or height
	self.m_LineHeight = self.m_FontSize

    EGUI.Manager:CallEvent("GUILabelCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Text, self.FontSize, self.m_LineHeight, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.Label:SetText(text)
	EGUI.Utils.CheckArgs("EGUI.Label:SetText", "string")
    self.m_Text = text
    EGUI.Manager:CallEvent("GUILabelSetText", self:GetId(), self.m_Text)
    return self
end

function EGUI.Label:GetText()
    return self.m_Text
end

function EGUI.Label:SetFontSize(size)
	EGUI.Utils.CheckArgs("EGUI.Label:SetFontSize", "number")
    self.m_FontSize = size
    EGUI.Manager:CallEvent("GUILabelSetFontSize", self:GetId(), self.m_FontSize)
    return self
end

function EGUI.Label:GetFontSize()
    return self.m_FontSize
end

function EGUI.Label:SetLineHeight(height)
	EGUI.Utils.CheckArgs("EGUI.Label:SetLineHeight", "number")
    self.m_LineHeight = height
    EGUI.Manager:CallEvent("GUILabelSetLineHeight", self:GetId(), self.m_LineHeight)
    return self
end

function EGUI.Label:GetLineHeight()
    return self.m_LineHeight
end
