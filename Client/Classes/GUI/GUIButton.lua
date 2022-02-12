EGUI.Button = EGUI.Classlib.Inherit(EGUI.InputBase)
EGUI.Button.Type = "Button"

EGUI.Manager:Subscribe(EGUI.Button.Type, "GUIButtonMouseUp")
EGUI.Manager:Subscribe(EGUI.Button.Type, "GUIButtonMouseDown")

EGUI.Button.Styles = {
    Default = "default",
    Rounded = "rounded",
    Outline = "outline"
}

function EGUI.Button:Constructor(posX, posY, width, height, text, parent)
	EGUI.Utils.CheckArgs("EGUI.Button:Constructor", "number", "number", "number", "number", "string", "?table")
    EGUI.InputBase.Constructor(self, posX, posY, width, height, parent)

    self.m_Text = text
    self.m_Color = EGUI.Color.Primary
    self.m_Style = EGUI.Button.Styles.Default

    EGUI.Manager:CallEvent("GUIButtonCreate", self:GetId(), self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Text, self.m_Parent and self.m_Parent:GetId() or nil)
end

function EGUI.Button:SetText(text)
	EGUI.Utils.CheckArgs("EGUI.Button:SetText", "string")
    self.m_Text = text
    EGUI.Manager:CallEvent("GUIButtonSetText", self:GetId(), self.m_Text)
    return self
end

function EGUI.Button:GetText()
    return self.m_Text
end

function EGUI.Button:SetStyle(style)
	EGUI.Utils.CheckArgs("EGUI.Button:SetStyle", "string")
    self.m_Style = style
    EGUI.Manager:CallEvent("GUIButtonSetColorStyle", self:GetId(), self.m_Color, self.m_Style)
    return self
end

function EGUI.Button:GetStyle()
    return self.m_Style
end

function EGUI.Button:SetColor(color)
	EGUI.Utils.CheckArgs("EGUI.Button:SetColor", "string")
    self.m_Color = color
    EGUI.Manager:CallEvent("GUIButtonSetColorStyle", self:GetId(), self.m_Color, self.m_Style)
    return self
end

function EGUI.Button:GetColor()
    return self.m_Color
end

function EGUI.Button:HandleEvent(event, ...)
    if event == "GUIButtonMouseUp" then
        self:Trigger("LeftClick")
    end
end
