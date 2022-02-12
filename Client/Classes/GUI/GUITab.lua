EGUI.Tab = EGUI.Classlib.Inherit(EGUI.Element)
EGUI.Tab.Type = "Tab"

function EGUI.Tab:Constructor(posX, posY, width, height, text, parent)
	EGUI.Utils.CheckArgs("EGUI.Tab:Constructor", "number", "number", "number", "number", "string", "?table")
    EGUI.Element.Constructor(self, posX, posY, width, height, parent)

	self.m_Text = text

    EGUI.Manager:CallEvent("GUITabCreate", self:GetId(), self.m_Text, self.m_Parent and self.m_Parent:GetId() or nil)
end
