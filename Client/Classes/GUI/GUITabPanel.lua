EGUI.TabPanel = EGUI.Classlib.Inherit(EGUI.Element)
EGUI.TabPanel.Type = "TabPanel"

function EGUI.TabPanel:Constructor(posX, posY, width, height, parent)
	EGUI.Utils.CheckArgs("EGUI.TabPanel:Constructor", "number", "number", "number", "number", "?table")
    EGUI.Element.Constructor(self, posX, posY, width, height, parent)

	self.m_Tabs = {}

    EGUI.Manager:CallEvent("GUITabPanelCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.TabPanel:AddTab(text)
	local tab = EGUI.Tab(0, 0, 0, 0, text, self)

	table.insert(self.m_Tabs, tab)

	return tab
end
