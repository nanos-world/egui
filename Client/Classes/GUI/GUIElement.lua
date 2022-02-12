EGUI.Element = EGUI.Classlib.Inherit(EGUI.Object)
EGUI.Element.Type = "Unknown"

function EGUI.Element:Constructor(posX, posY, width, height, parent)
    self.m_Id = EGUI.Manager:Register(self.Type, self)

    self.m_PosX = posX
    self.m_PosY = posY
    self.m_Width = width
    self.m_Height = height
    self.m_Parent = parent

	self.m_Children = {}
	self.m_Visible = true
	self.m_Alpha = 1
	self.m_Alignment = "topLeft";

    self.m_Events = {}

	if self.m_Parent then
		self.m_Parent:AddChild(self)
	end
end

function EGUI.Element:Destructor()
	for index = #self.m_Children, -1 do
		local element = self.m_Children[index]
		EGUI.Classlib.Delete(element)
	end

    EGUI.Manager:CallEvent("GUIElementDestroy", self:GetId())
end

function EGUI.Element:GetId()
    return self.m_Id
end

function EGUI.Element:SetVisible(state)
	EGUI.Utils.CheckArgs("EGUI.Element:SetVisible", "boolean")
	self.m_Visible = state
    EGUI.Manager:CallEvent("GUIElementSetVisible", self:GetId(), self.m_Visible)
	return self
end

function EGUI.Element:IsVisible()
	return self.m_Visible
end

function EGUI.Element:SetAlpha(alpha)
	EGUI.Utils.CheckArgs("EGUI.Element:SetAlpha", "number")
	self.m_Alpha = alpha
    EGUI.Manager:CallEvent("GUIElementSetAlpha", self:GetId(), self.m_Alpha)
	return self
end

function EGUI.Element:GetAlpha()
	return self.m_Alpha
end

function EGUI.Element:SetPosition(x, y)
	EGUI.Utils.CheckArgs("EGUI.Element:SetPosition", "number", "number")
	self.m_PosX = x
	self.m_PosY = y
    EGUI.Manager:CallEvent("GUIElementSetPosition", self:GetId(), self.m_PosX, self.m_PosY)
	return self
end

function EGUI.Element:GetPosition()
	return self.m_PosX, self.m_PosY
end

function EGUI.Element:SetSize(width, height)
	EGUI.Utils.CheckArgs("EGUI.Element:SetSize", "number", "number")
	self.m_Width = width
	self.m_Height = height
    EGUI.Manager:CallEvent("GUIElementSetSize", self:GetId(), self.m_Width, self.m_Height)
	return self
end

function EGUI.Element:GetSize()
	return self.m_Width, self.m_Height
end

function EGUI.Element:SetAlignment(alignment)
	self.m_Alignment = alignment
    EGUI.Manager:CallEvent("GUIElementSetAlignment", self:GetId(), self.m_Alignment)
	return self
end

function EGUI.Element:GetAlignment()
	return self.m_Alignment
end

function EGUI.Element:AddChild(child)
	table.insert(self.m_Children, child)
end

function EGUI.Element:RemoveChild(child)
	for k, v in ipairs(self.m_Children) do
		if v == child then
			table.remove(self.m_Children, k)
			return
		end
	end
end

function EGUI.Element:HandleEvent(event, ...)

end

function EGUI.Element:Trigger(event, ...)
    if not self.m_Events[event] then return end

    for k, v in ipairs(self.m_Events[event]) do
        v(...)
    end
end

function EGUI.Element:Subscribe(event, handler)
    if not self.m_Events[event] then
        self.m_Events[event] = {}
    end

    table.insert(self.m_Events[event], handler)
end

function EGUI.Element:Unsubscribe(event, handler)
    if not self.m_Events[event] then
        self.m_Events[event] = {}
    end

    if not handler then
        self.m_Events[event] = {}
    else
        for k, v in ipairs(self.m_Events[event]) do
            if v == handler then
                table.remove(self.m_Events, k)
                return
            end
        end
    end
end
