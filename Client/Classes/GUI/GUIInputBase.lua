EGUI.InputBase = EGUI.Classlib.Inherit(EGUI.Element)

function EGUI.InputBase:Constructor(posX, posY, width, height, parent)
	EGUI.Utils.CheckArgs("EGUI.InputBase:Constructor", "number", "number", "number", "number", "?table")
    EGUI.Element.Constructor(self, posX, posY, width, height, parent)
	self.m_Enabled = true
end

function EGUI.InputBase:SetEnabled(state)
	EGUI.Utils.CheckArgs("EGUI.InputBase:SetEnabled", "boolean")
    self.m_Enabled = state
    EGUI.Manager:CallEvent("GUIInputBaseSetEnabled", self:GetId(), self.m_Enabled)
    return self
end

function EGUI.InputBase:IsEnabled()
    return self.m_Enabled
end
