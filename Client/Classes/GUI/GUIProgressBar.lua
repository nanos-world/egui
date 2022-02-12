EGUI.ProgressBar = EGUI.Classlib.Inherit(EGUI.Element)
EGUI.ProgressBar.Type = "ProgressBar"

function EGUI.ProgressBar:Constructor(posX, posY, width, height, parent)
	EGUI.Utils.CheckArgs("EGUI.ProgressBar:Constructor", "number", "number", "number", "number", "?table")
    EGUI.Element.Constructor(self, posX, posY, width, height, parent)

    self.m_Value = 0

    EGUI.Manager:CallEvent("GUIProgressBarCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.ProgressBar:SetValue(value)
	EGUI.Utils.CheckArgs("EGUI.ProgressBar:SetValue", "number")
    self.m_Value = value
    EGUI.Manager:CallEvent("GUIProgressBarSetValue", self:GetId(), self.m_Value)
    return self
end

function EGUI.ProgressBar:GetValue()
    return self.m_Value
end
