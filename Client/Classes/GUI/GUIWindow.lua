EGUI.Window = EGUI.Classlib.Inherit(EGUI.Element)
EGUI.Window.Type = "Window"

EGUI.Manager:Subscribe(EGUI.Window.Type, "GUIWindowMove")
EGUI.Manager:Subscribe(EGUI.Window.Type, "GUIWindowCloseClick")

function EGUI.Window:Constructor(posX, posY, width, height, title, titlebarEnabled, closeButtonEnabled, parent)
	EGUI.Utils.CheckArgs("EGUI.Window:Constructor", "number", "number", "number", "number", "string", "?boolean", "?boolean", "?table")
    EGUI.Element.Constructor(self, posX, posY, width, height, parent)

    self.m_Title = title
    self.m_TitlebarEnabled = titlebarEnabled ~= nil and titlebarEnabled or true
    self.m_CloseButtonEnabled = closeButtonEnabled ~= nil and closeButtonEnabled or true

    EGUI.Manager:CallEvent("GUIWindowCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Title, self.m_TitlebarEnabled, self.m_CloseButtonEnabled, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.Window:SetTitle(title)
	EGUI.Utils.CheckArgs("EGUI.Window:SetTitle", "string")
    self.m_Title = title
    EGUI.Manager:CallEvent("GUIWindowSetTitle", self:GetId(), self.m_Title)
    return self
end

function EGUI.Window:GetTitle()
    return self.m_Title
end

function EGUI.Window:SetTitelbarEnabled(enabled)
	EGUI.Utils.CheckArgs("EGUI.Window:SetTitelbarEnabled", "boolean")
    self.m_TitlebarEnabled = enabled
    EGUI.Manager:CallEvent("GUIWindowSetTitelbarEnabled", self:GetId(), self.m_TitlebarEnabled)
    return self
end

function EGUI.Window:IsTitelbarEnabled()
    return self.m_TitlebarEnabled
end

function EGUI.Window:SetCloseButtonEnabled(enabled)
	EGUI.Utils.CheckArgs("EGUI.Window:SetCloseButtonEnabled", "boolean")
    self.m_CloseButtonEnabled = enabled
    EGUI.Manager:CallEvent("GUIWindowSetCloseButtonEnabled", self:GetId(), self.m_CloseButtonEnabled)
    return self
end

function EGUI.Window:IsCloseButtonEnabled()
    return self.m_CloseButtonEnabled
end

function EGUI.Window:BringToFront()
	EGUI.Manager:CallEvent("GUIWindowBringToFront", self:GetId())
    return self
end

function EGUI.Window:HandleEvent(event, ...)
    if event == "GUIWindowMove" then
		local params = {...}
		self.m_PosX = params[1]
		self.m_PosY = params[2]

        self:Trigger("Move", ...)
	elseif event == "GUIWindowCloseClick" then
		self:Trigger("CloseClick")
    end
end
